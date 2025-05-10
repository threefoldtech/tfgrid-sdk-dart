// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/pallet_membership/pallet/call.dart' as _i8;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i7;
import '../types/tfchain_runtime/runtime_call.dart' as _i6;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.AccountId32>> _members =
      const _i1.StorageValue<List<_i2.AccountId32>>(
    prefix: 'CouncilMembership',
    storage: 'Members',
    valueCodec: _i3.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()),
  );

  final _i1.StorageValue<_i2.AccountId32> _prime =
      const _i1.StorageValue<_i2.AccountId32>(
    prefix: 'CouncilMembership',
    storage: 'Prime',
    valueCodec: _i2.AccountId32Codec(),
  );

  /// The current membership, stored as an ordered Vec.
  _i4.Future<List<_i2.AccountId32>> members({_i1.BlockHash? at}) async {
    final hashedKey = _members.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _members.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The current prime member, if one exists.
  _i4.Future<_i2.AccountId32?> prime({_i1.BlockHash? at}) async {
    final hashedKey = _prime.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _prime.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `members`.
  _i5.Uint8List membersKey() {
    final hashedKey = _members.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `prime`.
  _i5.Uint8List primeKey() {
    final hashedKey = _prime.hashedKey();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::add_member`].
  _i6.CouncilMembership addMember({required _i7.MultiAddress who}) {
    return _i6.CouncilMembership(_i8.AddMember(who: who));
  }

  /// See [`Pallet::remove_member`].
  _i6.CouncilMembership removeMember({required _i7.MultiAddress who}) {
    return _i6.CouncilMembership(_i8.RemoveMember(who: who));
  }

  /// See [`Pallet::swap_member`].
  _i6.CouncilMembership swapMember({
    required _i7.MultiAddress remove,
    required _i7.MultiAddress add,
  }) {
    return _i6.CouncilMembership(_i8.SwapMember(
      remove: remove,
      add: add,
    ));
  }

  /// See [`Pallet::reset_members`].
  _i6.CouncilMembership resetMembers({required List<_i2.AccountId32> members}) {
    return _i6.CouncilMembership(_i8.ResetMembers(members: members));
  }

  /// See [`Pallet::change_key`].
  _i6.CouncilMembership changeKey({required _i7.MultiAddress new_}) {
    return _i6.CouncilMembership(_i8.ChangeKey(new_: new_));
  }

  /// See [`Pallet::set_prime`].
  _i6.CouncilMembership setPrime({required _i7.MultiAddress who}) {
    return _i6.CouncilMembership(_i8.SetPrime(who: who));
  }

  /// See [`Pallet::clear_prime`].
  _i6.CouncilMembership clearPrime() {
    return _i6.CouncilMembership(_i8.ClearPrime());
  }
}
