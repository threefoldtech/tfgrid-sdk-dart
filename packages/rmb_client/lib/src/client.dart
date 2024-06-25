part of "../rmb_client.dart";

class TwinsMap {
  Twin twin;
  int timestamp;

  TwinsMap(this.twin, this.timestamp);
  @override
  String toString() {
    return 'TwinsMap(twin: ${twin.id}, timestamp: $timestamp)';
  }
}

class Client {
  static final Map<String, Client> _connections = {};
  static final connectingLock = Lock();
  KeyPair? signer;
  Address source = Address();
  static final Map<String?, ClientEnvelope> responses = {};
  WebSocket? socket;
  Twin? twin;
  Twin? destTwin;
  TFClient.QueryClient? tfClient;
  Map<int, TwinsMap>? twins;
  String relayUrl;
  String chainUrl;
  String mnemonic;
  String session;
  int? retries;
  String keypairType;
  Timer? pingTimer;

  Client._internal(
    this.relayUrl,
    this.chainUrl,
    this.mnemonic,
    this.session, {
    this.retries = 5,
    required this.keypairType,
    this.twins,
  }) {
    tfClient = TFClient.QueryClient(chainUrl);
  }

  factory Client({
    required String relayUrl,
    required String chainUrl,
    required String mnemonic,
    required String session,
    int retries = 5,
    required String keypairType,
    Map<int, TwinsMap>? twins,
  }) {
    final key = '$relayUrl:$mnemonic:$keypairType';
    if (_connections.containsKey(key)) {
      return _connections[key]!;
    }

    if (keypairType != KPType.ed25519 && keypairType != KPType.sr25519) {
      throw UnsupportedError('Unsupported Keypair type');
    }

    final newClient = Client._internal(
      relayUrl,
      chainUrl,
      mnemonic,
      session,
      retries: retries,
      keypairType: keypairType,
      twins: twins,
    );

    _connections[key] = newClient;
    return newClient;
  }

  Future<void> createConnection() async {
    if (socket != null && socket!.closeCode == WebSocket.closed) {
      await socket!.close();
    }

    try {
      final wsUrl = await updateUrl();

      if (!wsUrl.startsWith('ws://') && !wsUrl.startsWith('wss://')) {
        throw Exception('Invalid WebSocket URL: $wsUrl');
      }

      try {
        socket = await WebSocket.connect(wsUrl);
        if (socket!.readyState == WebSocket.open) {
          socket!.listen((message) async {
            print("HELLO FROM Listening to response");

            final recievedEnvelope = Envelope.fromBuffer(message);
            print("Envelope Received: ${recievedEnvelope.hasResponse()}");

            final castedEnvelope = ClientEnvelope(
                envelope: recievedEnvelope,
                chainUrl: chainUrl,
                tfClient: tfClient!,
                twins: twins!);

            if (responses.containsKey(recievedEnvelope.uid)) {
              responses[recievedEnvelope.uid] = castedEnvelope;
              print("update envelope in responses map");
              // TODO:
              await read(recievedEnvelope.uid);
            }
          });
        } else {
          print(
              'Error: Could not open connection (readyState: ${socket!.readyState})');
        }
      } catch (error) {
        throw Exception("Unable to start connection $error");
      }
    } catch (error) {
      throw Exception('Unable to create websocket connection due to $error');
    }
  }

  Future<void> waitForOpenConnection() {
    final completer = Completer<void>();
    const maxNumberOfAttempts = 20;
    const intervalTime = Duration(milliseconds: 500);

    var currentAttempt = 0;
    Timer? timer;

    timer = Timer.periodic(intervalTime, (timer) {
      if (currentAttempt > maxNumberOfAttempts - 1) {
        timer.cancel();
        completer.completeError(
            throw Exception("Maximum number of attempts exceeded"));
      } else if (socket != null) {
        timer.cancel();
        completer.complete();
      }
      currentAttempt++;
    });

    return completer.future;
  }

  Future<void> connect() async {
    try {
      await Client.connectingLock.acquire();
      if (socket != null && socket!.closeCode == WebSocket.closed) {
        print("Already Connected!");
        return;
      }

      tfClient?.connect();
      await createSigner();

      final twinId = await tfClient?.twins.getTwinIdByAccountId(
          QueryTwinsGetTwinByAccountIdOptions(
              accountId: signer!.publicKey.bytes));
      if (twinId == 0) {
        throw "Couldn't find a user for the provided mnemonic on this network.";
      }
      twin = await tfClient?.twins.get(QueryTwinsGetOptions(id: twinId!));
      twins ??= {};
      twins![twin!.id.hashCode] = TwinsMap(
          twin!, (DateTime.now().millisecondsSinceEpoch / 1000).round());
      try {
        updateSource();
        await createConnection();
      } catch (error) {
        throw Exception(
            "Unable to establish connection with rmb relay: $error");
      }
    } catch (e) {
      throw Exception("Error Connecting on relay : $e");
    }
    // finally {
    //   connectingLock.release();
    // }
  }

  Future<String> newJWT(String session) async {
    Map<String, dynamic> header = {
      'alg': 'RS512',
      'typ': 'JWT',
    };

    int now = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    // TODO: TwinId should bs passed from params
    Map<String, dynamic> claims = {
      'sub': 7858,
      'iat': now,
      'exp': now + 1000,
      'sid': session,
    };

    String jwt =
        '${base64Url.encode(utf8.encode(jsonEncode(header)))}.${base64Url.encode(utf8.encode(jsonEncode(claims)))}';

    Uint8List sigPrefixed = sign(Uint8List.fromList(jwt.codeUnits), signer!);
    String token = '$jwt.${base64Url.encode(sigPrefixed)}';

    return token;
  }

  void updateSource() {
    source.twin = twin!.id;
    source.connection = session;
  }

  Future<String?> ping() async {
    try {
      var uuid = Uuid();

      final pingEnvelope = Envelope(
          uid: uuid.v4(),
          timestamp:
              Int64((DateTime.now().microsecondsSinceEpoch / 1000).round()),
          expiration: Int64(40),
          source: source,
          ping: Ping());

      pingEnvelope.destination = Address();

      final clientEnvelope = ClientEnvelope(
          signer: signer,
          envelope: pingEnvelope,
          chainUrl: chainUrl,
          tfClient: tfClient!,
          twins: twins!);

      var retriesCount = 0;
      while (socket!.readyState != WebSocket.open && retries! >= retriesCount) {
        try {
          await waitForOpenConnection();
        } catch (error) {
          if (retries == retriesCount) {
            throw Exception(
                'Failed to open connection after $retriesCount retries.');
          }
          await createConnection();
        }
      }

      responses[clientEnvelope.uid] = clientEnvelope;
      socket!.add(clientEnvelope.envelope.writeToBuffer());
      return clientEnvelope.uid;
    } catch (error) {
      throw Exception('Unable to send due to $error');
    }
  }

  Future<String?> send(String requestCommand, var requestData,
      int destinationTwinId, int expirationMinutes, int? retries) async {
    try {
      var uuid = Uuid();
      destTwin = await getTwin(destinationTwinId, twins!, tfClient!);

      // create new envelope with given data and destination
      final envelope = Envelope(
          uid: uuid.v4(),
          timestamp:
              Int64((DateTime.now().microsecondsSinceEpoch / 1000).round()),
          expiration: Int64(expirationMinutes * 60),
          source: source);
      envelope.destination = Address(twin: destTwin?.id);
      if (requestCommand.isNotEmpty) {
        envelope.request = Request(command: requestCommand);
      }
      final clientEnvelope = ClientEnvelope(
          signer: signer,
          envelope: envelope,
          chainUrl: chainUrl,
          tfClient: tfClient!,
          twins: twins!);

      var retriesCount = 0;
      if (requestData != null && requestData.toString().isNotEmpty) {
        clientEnvelope.plain = Uint8List.fromList(utf8.encode(requestData));
      } else {
        clientEnvelope.plain = Uint8List(0);
      }

      // TODO: this cause stackoverflow
      // clientEnvelope.relays =
      //     twin!.relay?.map((i) => i.toString()).toList() ?? [];

      // print("HEllo after ading relays");
      // print('Relays added to client envelope: ${clientEnvelope.relays}');

      if (signer != null) {
        print("Is It signed ???");
        clientEnvelope.signature = clientEnvelope.signEnvelope();
      }
      responses[clientEnvelope.uid] = clientEnvelope;

      try {
        if (socket!.readyState == WebSocket.open) {
          socket!.add(clientEnvelope.envelope.writeToBuffer());
          print('Message sent successfully.');
        } else {
          print("Error: WebSocket connection not open.");
        }
      } catch (error) {
        throw Exception("Couldn't send envelope to RMB. $error");
      }

      return clientEnvelope.uid;
    } catch (error) {
      throw Exception("Unable to send msg to RMB dut to $error");
    }
  }

  Future<void> read(String requestID) async {
    var envelope = responses[requestID];
    final now = DateTime.now().millisecondsSinceEpoch;
    while (envelope != null &&
        DateTime.now().millisecondsSinceEpoch <
            now + envelope.expiration!.toInt() * 1000) {
      envelope = responses[requestID];

      if (envelope != null && envelope.envelope.hasResponse()) {
        print("Let's verify envelope");
        bool verified = await envelope.verify();
        if (verified) {
          print("ENVELOPE PLAIN ${envelope.envelope.hasPlain()}");
          print("ENVELOPE Cipher ${envelope.envelope.hasCipher()}");

          if (envelope.envelope.hasPlain()) {
            final dataReceived = envelope.plain!;
            if (dataReceived.isNotEmpty) {
              try {
                final decodedData = utf8.decode(dataReceived);
                final parsedResponse = jsonDecode(decodedData);
                responses.remove(requestID);
                print("Parsed Response $parsedResponse");
              } catch (error) {
                print('Error processing data: $error');
                rethrow;
              }
            }
          } else if (envelope.envelope.hasCipher()) {
            print(String.fromCharCodes(twin!.pk as Iterable<int>));
            final decryptedCipher = await envelope.decrypt(mnemonic);
          }
        } else if (!verified) {
          print("Not Verified");
          responses.remove(requestID);
          throw Exception("Invalid signature, discarding response");
        }
      }

      if (envelope != null && envelope.envelope.hasError()) {
        throw Exception("ENVELOPE ERROR: ${envelope.error!.message}");
      }
    }
  }

  Future<void> createSigner() async {
    if (keypairType == KPType.ed25519) {
      signer = await KeyPair.ed25519.fromMnemonic(mnemonic);
    } else if (keypairType == KPType.sr25519) {
      signer = await KeyPair.sr25519.fromMnemonic(mnemonic);
    } else {
      throw UnsupportedError('Unsupported Keypair type');
    }
  }

  // void closeConnection() {
  //   if (channel != null) {
  //     channel!.sink.close();
  //   }
  // }

  Future<String> updateUrl() async {
    final token = await newJWT(session);
    return '$relayUrl?$token';
  }
}
