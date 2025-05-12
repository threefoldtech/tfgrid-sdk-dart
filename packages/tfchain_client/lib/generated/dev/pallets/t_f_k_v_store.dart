// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/pallet_kvstore/pallet/call.dart' as _i7;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/tfchain_runtime/runtime_call.dart' as _i6;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageDoubleMap<_i2.AccountId32, List<int>, List<int>> _tFKVStore =
      const _i1.StorageDoubleMap<_i2.AccountId32, List<int>, List<int>>(
    prefix: 'TFKVStore',
    storage: 'TFKVStore',
    valueCodec: _i3.U8SequenceCodec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i2.AccountId32Codec()),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U8SequenceCodec.codec),
  );

  _i4.Future<List<int>> tFKVStore(
    _i2.AccountId32 key1,
    List<int> key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _tFKVStore.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _tFKVStore.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// Returns the storage key for `tFKVStore`.
  _i5.Uint8List tFKVStoreKey(
    _i2.AccountId32 key1,
    List<int> key2,
  ) {
    final hashedKey = _tFKVStore.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage map key prefix for `tFKVStore`.
  _i5.Uint8List tFKVStoreMapPrefix(_i2.AccountId32 key1) {
    final hashedKey = _tFKVStore.mapPrefix(key1);
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::set`].
  _i6.TFKVStore set({
    required List<int> key,
    required List<int> value,
  }) {
    return _i6.TFKVStore(_i7.Set(
      key: key,
      value: value,
    ));
  }

  /// See [`Pallet::delete`].
  _i6.TFKVStore delete({required List<int> key}) {
    return _i6.TFKVStore(_i7.Delete(key: key));
  }
}
