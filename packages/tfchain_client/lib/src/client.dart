part of '../tfchain_client.dart';

class QueryClient {
  final String url;
  late final Provider? provider;
  late final polkadot.Dev api;
  QueryTwins? _twins;
  QueryContracts? _contracts;
  balance.QueryBalances? _balances;
  QueryFarms? _farms;
  QueryNodes? _nodes;
  QueryPricingPolicies? _policies;
  QueryBridge? _bridge;
  QueryTFTPrice? _price;
  Dao.QueryDao? _dao;

  QueryClient(this.url) {}

  QueryTwins get twins {
    if (_twins == null) _twins = QueryTwins(this);
    return _twins!;
  }

  QueryContracts get contracts {
    if (_twins == null) _contracts = QueryContracts(this);
    return _contracts!;
  }

  balance.QueryBalances get balances {
    if (_balances == null) _balances = balance.QueryBalances(this);
    return _balances!;
  }

  QueryFarms get farms {
    if (_farms == null) _farms = QueryFarms(this);
    return _farms!;
  }

  QueryNodes get nodes {
    if (_nodes == null) _nodes = QueryNodes(this);
    return _nodes!;
  }

  QueryPricingPolicies get policies {
    if (_policies == null) _policies = QueryPricingPolicies(this);
    return _policies!;
  }

  QueryBridge get bridge {
    if (_bridge == null) _bridge = QueryBridge(this);
    return _bridge!;
  }

  QueryTFTPrice get price {
    if (_price == null) _price = QueryTFTPrice(this);
    return _price!;
  }

  Dao.QueryDao get dao {
    if (_dao == null) _dao = Dao.QueryDao(this);
    return _dao!;
  }

  void _checkInputs() {
    if (url.isEmpty) {
      throw FormatException("URL should be provided");
    }
  }

  Future<void> connect() async {
    _checkInputs();
    provider = Provider.fromUri(Uri.parse(url));
    api = polkadot.Dev(provider!);
  }

  Future<void> disconnect() async {
    if (provider!.isConnected()) {
      await api.disconnect();
    }
  }
}

class Client extends QueryClient {
  final String mnemonic;
  late String address;
  final String keypairType;
  KeyPair? keypair;
  KVStore? _kvStore;
  final SUPPORTED_KEYPAIR_TYPES = ["sr25519", "ed25519"];

  Client(String url, this.mnemonic, this.keypairType) : super(url) {}

  @override
  Twins get twins {
    if (_twins == null) _twins = Twins(this);
    return _twins as Twins;
  }

  @override
  Contracts get contracts {
    if (_contracts == null) _contracts = Contracts(this);
    return _contracts as Contracts;
  }

  @override
  balance.Balances get balances {
    if (_balances == null) _balances = balance.Balances(this);
    return _balances as balance.Balances;
  }

  @override
  Farms get farms {
    if (_farms == null) _farms = Farms(this);
    return _farms as Farms;
  }

  @override
  Nodes get nodes {
    if (_nodes == null) _nodes = Nodes(this);
    return _nodes as Nodes;
  }

  @override
  Bridge get bridge {
    if (_bridge == null) _bridge = Bridge(this);
    return _bridge as Bridge;
  }

  @override
  Dao.Dao get dao {
    if (_dao == null) _dao = Dao.Dao(this);
    return _dao as Dao.Dao;
  }

  KVStore get kvStore {
    if (_kvStore == null) _kvStore = KVStore(this);
    return _kvStore as KVStore;
  }

  @override
  void _checkInputs() {
    super._checkInputs();
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
    _checkInputs();
    final Signer.Signer signer = Signer.Signer();
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
        if (p0.type == 'finalized') {
          print("Extrinsic result: ${p0.type} - ${p0.value}");
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
                    String? errorName;
                    try {
                      if (errorType == "Module")
                        errorName = Errors(
                                moduleIndex: error["index"],
                                errorIndex:
                                    dynamicListToUint8List(error["error"]))
                            .decode();
                    } catch (e) {
                      _complete.completeError("Failed to apply extrinsic: $e");
                    }
                    if (errorName != null)
                      _complete.completeError(
                          "Failed to apply extrinsic: $errorName");
                    else
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
    await _complete.future;
    subscription.cancel();
  }
}
