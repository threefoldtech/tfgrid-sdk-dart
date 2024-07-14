part of '../tfchain_client.dart';

class QueryClient {
  final String url;
  late final Provider? provider;
  late final polkadot.Dev api;
  late final QueryContracts contracts;
  late final balance.QueryBalances balances;
  late final QueryFarms farms;
  late final QueryNodes nodes;
  late final QueryPricingPolicies policies;
  late final QueryTwins twins;
  late final QueryBridge bridge;
  late final Dao.QueryDao dao;
  late final QueryTFTPrice price;

  QueryClient(this.url) {
    provider = Provider.fromUri(Uri.parse(url));
    api = polkadot.Dev(provider!);
    contracts = QueryContracts(this);
    balances = balance.QueryBalances(this);
    farms = QueryFarms(this);
    nodes = QueryNodes(this);
    policies = QueryPricingPolicies(this);
    twins = QueryTwins(this);
    bridge = QueryBridge(this);
    price = QueryTFTPrice(this);
    dao = Dao.QueryDao(this);
  }

  void checkInputs() {
    if (url.isEmpty) {
      throw FormatException("URL should be provided");
    }
  }

  Future<void> connect() async {
    checkInputs();
  }

  Future<void> disconnect() async {
    await api.disconnect();
  }
}

class Client extends QueryClient {
  final String mnemonic;
  late String address;
  final String keypairType;
  late Signer.Signer signer;
  KeyPair? keypair;
  late final balance.Balances clientBalances;
  late final Contracts clientContracts;
  late final Farms clientFarms;
  late final Dao.Dao clientDao;
  late final Twins clientTwins;
  late final KVStore kvStrore;
  final SUPPORTED_KEYPAIR_TYPES = ["sr25519", "ed25519"];

  Client(String url, this.mnemonic, this.keypairType) : super(url) {
    if (provider == null) {
      provider = Provider.fromUri(Uri.parse(url));
      api = polkadot.Dev(provider!);
    }
    clientBalances = balance.Balances(this);
    clientContracts = Contracts(this);
    clientFarms = Farms(this);
    clientDao = Dao.Dao(this);
    clientTwins = Twins(this);
    kvStrore = KVStore(this);
    signer = Signer.Signer();
  }

  @override
  void checkInputs() {
    super.checkInputs();
    if (mnemonic.isEmpty) {
      throw FormatException("Mnemonic or secret should be provided");
    } else if (mnemonic != "//Allice" && !validateMnemonic(mnemonic)) {
      if (mnemonic.contains(" ")) {
        throw FormatException("Invalid mnemonic! Must be bip39 compliant");
      }

      if (!mnemonic.startsWith("0x")) {
        throw FormatException(
            "Invalid secret seed. Secret seed should start with 0x");
      }
    }

    if (!SUPPORTED_KEYPAIR_TYPES.contains(keypairType)) {
      throw FormatException(
          "Keypair type $keypairType is not valid. It Should be either of : ${SUPPORTED_KEYPAIR_TYPES}");
    }
  }

  @override
  Future<void> connect() async {
    await super.connect();
    checkInputs();
    if (keypairType == "sr25519") {
      keypair = await signer.fromMnemonic(mnemonic, Signer.KPType.sr25519);
      address = keypair!.address;
    } else {
      keypair = await signer.fromMnemonic(mnemonic, Signer.KPType.ed25519);
      address = keypair!.address;
    }
  }

  @override
  Future<void> disconnect() async {
    await api.disconnect();
  }

  Uint8List hexToBytes(String hexString) {
    if (hexString.startsWith('0x')) {
      hexString = hexString.substring(2);
    }
    return Uint8List.fromList(hex.decode(hexString));
  }

  dynamic replaceMapEntry(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value
          .map((key, innerValue) => MapEntry(key, replaceMapEntry(innerValue)));
    } else if (value is List) {
      return value.map((innerValue) => replaceMapEntry(innerValue)).toList();
    } else {
      return value;
    }
  }

  List<int> _getMyEventsPhaseId(List<dynamic> events) {
    final Set<int> phaseIds = Set();
    for (final event in events) {
      if (event["event"] != null &&
          event["event"].key == "TransactionPayment" &&
          ListEquality().equals(
              event["event"].value.value[0], keypair!.publicKey.bytes)) {
        phaseIds.add(event['phase'].value);
      }
    }
    return phaseIds.toList();
  }

  List<dynamic> _filterMyEvents(List<dynamic> events) {
    final List<dynamic> myEvents = [];
    final phaseIds = _getMyEventsPhaseId(events);
    for (final event in events) {
      if (phaseIds.contains(event["phase"].value)) {
        myEvents.add(event["event"]);
      }
    }
    return myEvents;
  }

  Future<void> apply(RuntimeCall runtimeCall) async {
    if (provider == null) {
      throw Exception("Provider is not initialized");
    }
    final stateApi = StateApi(provider!);

    final runtimeVersion = await stateApi.getRuntimeVersion();

    final specVersion = runtimeVersion.specVersion;

    final transactionVersion = runtimeVersion.transactionVersion;

    final block = await provider!.send('chain_getBlock', []);

    final blockNumber = int.parse(block.result['block']['header']['number']);

    final blockHash = (await provider!.send('chain_getBlockHash', []))
        .result
        .replaceAll('0x', '');

    final genesisHash = (await provider!.send('chain_getBlockHash', [0]))
        .result
        .replaceAll('0x', '');

    final encodedCall = runtimeCall.encode();
    final nonce = await api.rpc.system.accountNextIndex(address);
    final metadata = await api.rpc.state.getMetadata();

    // await api.rpc.state.queryStorageAt(keys)
    // state vs systemApi
    // different naming between polkadot vs flutter
    // how to make rpc call on state
    final payloadToSign = SigningPayload(
        method: encodedCall,
        specVersion: specVersion,
        transactionVersion: transactionVersion,
        genesisHash: genesisHash,
        blockHash: blockHash,
        blockNumber: blockNumber,
        eraPeriod: 64,
        nonce: nonce,
        tip: 0);

    final payload = payloadToSign.encode(api.registry);

    final signature = keypair!.sign(payload);

    // final hexSignature = hex.encode(signature);

    // final publicKey = hex.encode(keyring.publicKey.bytes);
    final signatureType = keypairType == "sr25519"
        ? SignatureType.sr25519
        : SignatureType.ed25519;
    final extrinsic = ExtrinsicPayload(
            signer: Uint8List.fromList(keypair!.bytes()),
            method: encodedCall,
            signature: signature,
            eraPeriod: 64,
            blockNumber: blockNumber,
            nonce: nonce,
            tip: 0)
        .encode(api.registry, signatureType);

    // final hexExtrinsic = hex.encode(extrinsic);
    // final input = Input.fromHex(hexExtrinsic);
    // final dynamic extrinsicDecoded =
    //     ExtrinsicsCodec(chainInfo: metadata.chainInfo).decode(input);
    // print(extrinsicDecoded);
    Completer<void> _complete = Completer();
    final StreamSubscription subscription =
        await AuthorApi(provider!).submitAndWatchExtrinsic(
      extrinsic,
      (p0) async {
        print("Extrinsic result: ${p0.type} - ${p0.value}");
        if (p0.type == 'inBlock') {
          final finalizedBlockHash = p0.value;
          final moduleHash =
              Hasher.twoxx128.hash(Uint8List.fromList('System'.codeUnits));
          final storageHash =
              Hasher.twoxx128.hash(Uint8List.fromList('Events'.codeUnits));
          Uint8List storageKey = Uint8List.fromList([
            ...moduleHash,
            ...storageHash,
          ]);
          final finalizedBlockHashBytes = hexToBytes(finalizedBlockHash);
          final changes = await stateApi
              .queryStorageAt([storageKey], at: finalizedBlockHashBytes);
          if (changes != Null && changes.isNotEmpty) {
            for (var changeSet in changes) {
              for (var change in changeSet.changes) {
                Uint8List key = change.key;
                Uint8List value = change.value!;

                final input = Input.fromBytes(value);
                final List<dynamic> decodedEvents =
                    metadata.chainInfo.scaleCodec.decode('EventCodec', input);
                final myEvents = _filterMyEvents(decodedEvents);
                bool targetModuleEventOccur = false;
                for (final event in myEvents) {
                  if (event.key == "System" &&
                      event.value.key == "ExtrinsicFailed") {
                    // TODO: get the error name and type
                    final error = event.value.value["DispatchError"].value;
                    final errorType = event.value.value["DispatchError"].key;
                    _complete.completeError(
                        "Failed to apply extrinsic: ${errorType}${error}");
                  } else if (event.key == runtimeCall.runtimeType.toString()) {
                    targetModuleEventOccur = true;
                  } else if (targetModuleEventOccur &&
                      event.key == "System" &&
                      event.value.key == "ExtrinsicSuccess") {
                    print("Extrinsic is applied successfully");
                    _complete.complete();
                    return;
                  }
                }
              }
            }
          } else {
            _complete.completeError("No events found in the block");
          }
        }
      },
    );
    Future<void> _myFuture() async {
      return _complete.future;
    }

    await _myFuture();
    subscription.cancel();
  }
}
