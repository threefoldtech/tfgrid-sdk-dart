part of "../rmb_client.dart";

class Client {
  KeyPair? signer;
  String relayUrl;
  String chainUrl;
  String mnemonic;
  String session;
  int? twin;
  WebSocketChannel? channel;
  int? retries;
  TFClient.QueryClient? client;
  String keypairType;
  var connections = new Map();

  Client(
    this.relayUrl,
    this.chainUrl,
    this.mnemonic,
    this.session, {
    this.retries = 5,
    required this.keypairType,
  }) {
    final key = '${relayUrl}:${mnemonic}:${keypairType}';
    if (connections.containsKey(key)) {
      // TODO: how to return from constructor ??
      // return connections[key] as Client;
    }

    client = TFClient.QueryClient(chainUrl);
    client?.connect();
  }

  Future<void> connect() async {
    // if (channel != null) {
    //   print("Already connected to relay.");
    //   return;
    // }
    final jwt = await newJWT(this.session);
    String resultString = jwt.replaceAll('=', '');

    try {
      final wsUrl = Uri.parse('${relayUrl}?$resultString');
      print(wsUrl);
      channel = WebSocketChannel.connect(wsUrl);
      print("connected to relay ");

      print(signer!.address);
      twin = await client?.twins.getTwinIdByAccountId(
          QueryTwinsGetTwinByAccountIdOptions(
              accountId: signer!.publicKey.bytes));
      print(twin);
      if (twin == 0) {
        throw "Couldn't find a user for the provided mnemonic on this network.";
      }

      await channel!.ready;
    } catch (e) {
      print("Error Connecting on relay : $e");
    }
  }

  Future<String> newJWT(String session) async {
    Map<String, dynamic> header = {
      'alg': 'RS512',
      'typ': 'JWT',
    };

    int now = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    // TODO: TwinId should bs passed from params
    Map<String, dynamic> claims = {
      'sub': 5261,
      'iat': now,
      'exp': now + 1000,
      'sid': session,
    };

    String jwt =
        '${base64Url.encode(utf8.encode(jsonEncode(header)))}.${base64Url.encode(utf8.encode(jsonEncode(claims)))}';

    if (keypairType == KPType.ed25519) {
      signer = await KeyPair.ed25519.fromMnemonic(mnemonic);
    } else if (keypairType == KPType.sr25519) {
      signer = await KeyPair.sr25519.fromMnemonic(mnemonic);
    }

    Uint8List sigPrefixed = sign(Uint8List.fromList(jwt.codeUnits), signer!);
    String token = '$jwt.${base64Url.encode(sigPrefixed)}';

    return token;
  }

  void closeConnection() {
    if (channel != null) {
      channel!.sink.close();
    }
  }
}
