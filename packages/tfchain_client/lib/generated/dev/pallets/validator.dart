// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/pallet_validator/pallet/call.dart' as _i7;
import '../types/pallet_validator/types/validator.dart' as _i3;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i8;
import '../types/tfchain_runtime/runtime_call.dart' as _i6;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.AccountId32, _i3.Validator> _validator =
      const _i1.StorageMap<_i2.AccountId32, _i3.Validator>(
    prefix: 'Validator',
    storage: 'Validator',
    valueCodec: _i3.Validator.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.AccountId32Codec()),
  );

  final _i1.StorageMap<_i2.AccountId32, _i2.AccountId32> _bonded =
      const _i1.StorageMap<_i2.AccountId32, _i2.AccountId32>(
    prefix: 'Validator',
    storage: 'Bonded',
    valueCodec: _i2.AccountId32Codec(),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.AccountId32Codec()),
  );

  _i4.Future<_i3.Validator?> validator(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _validator.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _validator.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i4.Future<_i2.AccountId32?> bonded(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _bonded.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bonded.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `validator`.
  _i5.Uint8List validatorKey(_i2.AccountId32 key1) {
    final hashedKey = _validator.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `bonded`.
  _i5.Uint8List bondedKey(_i2.AccountId32 key1) {
    final hashedKey = _bonded.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `validator`.
  _i5.Uint8List validatorMapPrefix() {
    final hashedKey = _validator.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `bonded`.
  _i5.Uint8List bondedMapPrefix() {
    final hashedKey = _bonded.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::create_validator_request`].
  _i6.Validator createValidatorRequest({
    required _i2.AccountId32 validatorNodeAccount,
    required _i2.AccountId32 stashAccount,
    required List<int> description,
    required List<int> tfConnectId,
    required List<int> info,
  }) {
    return _i6.Validator(_i7.CreateValidatorRequest(
      validatorNodeAccount: validatorNodeAccount,
      stashAccount: stashAccount,
      description: description,
      tfConnectId: tfConnectId,
      info: info,
    ));
  }

  /// See [`Pallet::activate_validator_node`].
  _i6.Validator activateValidatorNode() {
    return _i6.Validator(_i7.ActivateValidatorNode());
  }

  /// See [`Pallet::change_validator_node_account`].
  _i6.Validator changeValidatorNodeAccount(
      {required _i2.AccountId32 newNodeValidatorAccount}) {
    return _i6.Validator(_i7.ChangeValidatorNodeAccount(
        newNodeValidatorAccount: newNodeValidatorAccount));
  }

  /// See [`Pallet::bond`].
  _i6.Validator bond({required _i8.MultiAddress validator}) {
    return _i6.Validator(_i7.Bond(validator: validator));
  }

  /// See [`Pallet::approve_validator`].
  _i6.Validator approveValidator({required _i8.MultiAddress validatorAccount}) {
    return _i6.Validator(
        _i7.ApproveValidator(validatorAccount: validatorAccount));
  }

  /// See [`Pallet::remove_validator`].
  _i6.Validator removeValidator({required _i8.MultiAddress validatorAccount}) {
    return _i6.Validator(
        _i7.RemoveValidator(validatorAccount: validatorAccount));
  }
}
