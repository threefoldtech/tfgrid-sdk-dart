import 'dart:convert';

import 'package:tfchain_client/generated/dev/dev.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_runtime/runtime.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_runtime/runtime_call.dart';
import 'package:tfchain_client/models/kvstore.dart';
import 'package:tfchain_client/tfchain_client.dart';

class KVStore {
  final Client client;

  KVStore(this.client);

  RuntimeCall set(KVStoreSetOptions options) {
    final extrinsic = client.api.tx.tFKVStore
        .set(key: options.key.codeUnits, value: options.value.codeUnits);
    return extrinsic;
  }

  RuntimeCall delete(KVStoreGetOptions options) {
    final extrinsic =
        client.api.tx.tFKVStore.delete(key: options.key.codeUnits);
    return extrinsic;
  }

  Future<String> get(KVStoreGetOptions options) async {
    final res = await client.api.query.tFKVStore
        .tFKVStore(client.keypair!.publicKey.bytes, options.key.codeUnits);
    return String.fromCharCodes(res);
  }

  void list() async {
    // final queries = client.api.query.
    // final res = await queries.tFKVStore.
  }

  void deleteAll(){

  }
}
