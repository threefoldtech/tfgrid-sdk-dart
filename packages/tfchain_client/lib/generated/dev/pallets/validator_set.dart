// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/substrate_validator_set/pallet/call.dart' as _i7;
import '../types/tfchain_runtime/runtime_call.dart' as _i6;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.AccountId32>> _validators =
      const _i1.StorageValue<List<_i2.AccountId32>>(
    prefix: 'ValidatorSet',
    storage: 'Validators',
    valueCodec: _i3.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()),
  );

  final _i1.StorageValue<List<_i2.AccountId32>> _approvedValidators =
      const _i1.StorageValue<List<_i2.AccountId32>>(
    prefix: 'ValidatorSet',
    storage: 'ApprovedValidators',
    valueCodec: _i3.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()),
  );

  final _i1.StorageValue<List<_i2.AccountId32>> _offlineValidators =
      const _i1.StorageValue<List<_i2.AccountId32>>(
    prefix: 'ValidatorSet',
    storage: 'OfflineValidators',
    valueCodec: _i3.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()),
  );

  _i4.Future<List<_i2.AccountId32>> validators({_i1.BlockHash? at}) async {
    final hashedKey = _validators.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _validators.decodeValue(bytes);
    }
    return []; /* Default */
  }

  _i4.Future<List<_i2.AccountId32>> approvedValidators(
      {_i1.BlockHash? at}) async {
    final hashedKey = _approvedValidators.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _approvedValidators.decodeValue(bytes);
    }
    return []; /* Default */
  }

  _i4.Future<List<_i2.AccountId32>> offlineValidators(
      {_i1.BlockHash? at}) async {
    final hashedKey = _offlineValidators.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _offlineValidators.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Returns the storage key for `validators`.
  _i5.Uint8List validatorsKey() {
    final hashedKey = _validators.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `approvedValidators`.
  _i5.Uint8List approvedValidatorsKey() {
    final hashedKey = _approvedValidators.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `offlineValidators`.
  _i5.Uint8List offlineValidatorsKey() {
    final hashedKey = _offlineValidators.hashedKey();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::add_validator`].
  _i6.ValidatorSet addValidator({required _i2.AccountId32 validatorId}) {
    return _i6.ValidatorSet(_i7.AddValidator(validatorId: validatorId));
  }

  /// See [`Pallet::remove_validator`].
  _i6.ValidatorSet removeValidator({required _i2.AccountId32 validatorId}) {
    return _i6.ValidatorSet(_i7.RemoveValidator(validatorId: validatorId));
  }

  /// See [`Pallet::add_validator_again`].
  _i6.ValidatorSet addValidatorAgain({required _i2.AccountId32 validatorId}) {
    return _i6.ValidatorSet(_i7.AddValidatorAgain(validatorId: validatorId));
  }
}
