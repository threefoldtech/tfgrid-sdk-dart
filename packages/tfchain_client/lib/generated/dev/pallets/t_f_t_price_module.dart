// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/pallet_tft_price/pallet/call.dart' as _i7;
import '../types/tfchain_runtime/runtime_call.dart' as _i6;
import '../types/tuples.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _tftPrice = const _i1.StorageValue<int>(
    prefix: 'TFTPriceModule',
    storage: 'TftPrice',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _lastBlockSet = const _i1.StorageValue<int>(
    prefix: 'TFTPriceModule',
    storage: 'LastBlockSet',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _averageTftPrice = const _i1.StorageValue<int>(
    prefix: 'TFTPriceModule',
    storage: 'AverageTftPrice',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, int> _tftPriceHistory =
      const _i1.StorageMap<int, int>(
    prefix: 'TFTPriceModule',
    storage: 'TftPriceHistory',
    valueCodec: _i2.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.U16Codec.codec),
  );

  final _i1.StorageValue<_i3.Tuple2<int, int>> _bufferRange =
      const _i1.StorageValue<_i3.Tuple2<int, int>>(
    prefix: 'TFTPriceModule',
    storage: 'BufferRange',
    valueCodec: _i3.Tuple2Codec<int, int>(
      _i2.U16Codec.codec,
      _i2.U16Codec.codec,
    ),
  );

  final _i1.StorageValue<int> _minTftPrice = const _i1.StorageValue<int>(
    prefix: 'TFTPriceModule',
    storage: 'MinTftPrice',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _maxTftPrice = const _i1.StorageValue<int>(
    prefix: 'TFTPriceModule',
    storage: 'MaxTftPrice',
    valueCodec: _i2.U32Codec.codec,
  );

  _i4.Future<int> tftPrice({_i1.BlockHash? at}) async {
    final hashedKey = _tftPrice.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _tftPrice.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i4.Future<int> lastBlockSet({_i1.BlockHash? at}) async {
    final hashedKey = _lastBlockSet.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lastBlockSet.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i4.Future<int> averageTftPrice({_i1.BlockHash? at}) async {
    final hashedKey = _averageTftPrice.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _averageTftPrice.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i4.Future<int> tftPriceHistory(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _tftPriceHistory.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _tftPriceHistory.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i4.Future<_i3.Tuple2<int, int>> bufferRange({_i1.BlockHash? at}) async {
    final hashedKey = _bufferRange.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bufferRange.decodeValue(bytes);
    }
    return _i3.Tuple2<int, int>(
      0,
      0,
    ); /* Default */
  }

  _i4.Future<int> minTftPrice({_i1.BlockHash? at}) async {
    final hashedKey = _minTftPrice.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _minTftPrice.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i4.Future<int> maxTftPrice({_i1.BlockHash? at}) async {
    final hashedKey = _maxTftPrice.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _maxTftPrice.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Returns the storage key for `tftPrice`.
  _i5.Uint8List tftPriceKey() {
    final hashedKey = _tftPrice.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `lastBlockSet`.
  _i5.Uint8List lastBlockSetKey() {
    final hashedKey = _lastBlockSet.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `averageTftPrice`.
  _i5.Uint8List averageTftPriceKey() {
    final hashedKey = _averageTftPrice.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `tftPriceHistory`.
  _i5.Uint8List tftPriceHistoryKey(int key1) {
    final hashedKey = _tftPriceHistory.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `bufferRange`.
  _i5.Uint8List bufferRangeKey() {
    final hashedKey = _bufferRange.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `minTftPrice`.
  _i5.Uint8List minTftPriceKey() {
    final hashedKey = _minTftPrice.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `maxTftPrice`.
  _i5.Uint8List maxTftPriceKey() {
    final hashedKey = _maxTftPrice.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `tftPriceHistory`.
  _i5.Uint8List tftPriceHistoryMapPrefix() {
    final hashedKey = _tftPriceHistory.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::set_prices`].
  _i6.TFTPriceModule setPrices({
    required int price,
    required int blockNumber,
  }) {
    return _i6.TFTPriceModule(_i7.SetPrices(
      price: price,
      blockNumber: blockNumber,
    ));
  }

  /// See [`Pallet::set_min_tft_price`].
  _i6.TFTPriceModule setMinTftPrice({required int price}) {
    return _i6.TFTPriceModule(_i7.SetMinTftPrice(price: price));
  }

  /// See [`Pallet::set_max_tft_price`].
  _i6.TFTPriceModule setMaxTftPrice({required int price}) {
    return _i6.TFTPriceModule(_i7.SetMaxTftPrice(price: price));
  }
}
