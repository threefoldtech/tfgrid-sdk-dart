import 'dart:typed_data';
import 'package:polkadart/polkadart.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_runtime/runtime_call.dart';
import 'package:tfchain_client/tfchain_client.dart';

class KVStore {
  final Client client;

  KVStore(this.client);

  RuntimeCall set({required String key, required String value}) {
    final extrinsic =
        client.api.tx.tFKVStore.set(key: key.codeUnits, value: value.codeUnits);
    return extrinsic;
  }

  RuntimeCall delete({required String key}) {
    final extrinsic = client.api.tx.tFKVStore.delete(key: key.codeUnits);
    return extrinsic;
  }

  Future<String> get({required String key}) async {
    final res = await client.api.query.tFKVStore
        .tFKVStore(client.keypair!.publicKey.bytes, []);
    print(res);
    return String.fromCharCodes(res);
  }

  Future<Map<String, String>> list() async {
    final moduleHash =
        Hasher.twoxx128.hash(Uint8List.fromList('TFKVStore'.codeUnits));

    final functionHash =
        Hasher.twoxx128.hash(Uint8List.fromList('TFKVStore'.codeUnits));

    final keyHash = Hasher.blake2b128
        .hash(Uint8List.fromList(client.keypair!.publicKey.bytes));

    Uint8List partialKey = Uint8List.fromList([
      ...moduleHash,
      ...functionHash,
      ...keyHash,
      ...client.keypair!.publicKey.bytes
    ]);

    List<Uint8List> keys = [];
    int count = 2;
    Uint8List? startKey;
    bool hasMore = true;

    while (hasMore) {
      final keysPage = await client.api.rpc.state.getKeysPaged(
        key: partialKey,
        count: count,
        startKey: startKey,
      );

      if (keysPage.isEmpty) {
        hasMore = false;
      } else {
        keys.addAll(keysPage);
        startKey = keysPage.last;
      }
    }

    final keysValues = await client.api.rpc.state.queryStorageAt(keys);

    Map<String, String> keyValueMap = {};

    for (var change in keysValues[0].changes) {
      final key = change.key;
      var value = change.value;

      final added = key.sublist(partialKey.length + 17);

      value = value!.sublist(1);
      keyValueMap[String.fromCharCodes(added)] = String.fromCharCodes(value);
    }

    print(keyValueMap);
    return keyValueMap;
  }

  void deleteAll() async {
    Map<String, String> keys = await list();

    for (String key in keys.keys) {
      final extrinsic = delete(key: key);
      await client.apply(extrinsic);
    }
  }
}
