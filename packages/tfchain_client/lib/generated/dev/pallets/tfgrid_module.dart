// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i13;
import 'dart:typed_data' as _i18;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/pallet_tfgrid/pallet/call.dart' as _i20;
import '../types/pallet_tfgrid/terms_cond/terms_and_conditions.dart' as _i10;
import '../types/pallet_tfgrid/types/entity.dart' as _i5;
import '../types/pallet_tfgrid/types/farming_policy.dart' as _i9;
import '../types/pallet_tfgrid/types/location_input.dart' as _i23;
import '../types/pallet_tfgrid/types/policy.dart' as _i26;
import '../types/pallet_tfgrid/types/pricing_policy.dart' as _i8;
import '../types/pallet_tfgrid/types/storage_version.dart' as _i11;
import '../types/pallet_tfgrid/types/twin.dart' as _i7;
import '../types/sp_core/crypto/account_id32.dart' as _i6;
import '../types/tfchain_runtime/runtime_call.dart' as _i19;
import '../types/tfchain_support/resources/resources.dart' as _i22;
import '../types/tfchain_support/types/farm.dart' as _i2;
import '../types/tfchain_support/types/farm_certification.dart' as _i15;
import '../types/tfchain_support/types/farming_policy_limit.dart' as _i27;
import '../types/tfchain_support/types/interface_2.dart' as _i24;
import '../types/tfchain_support/types/ip4.dart' as _i21;
import '../types/tfchain_support/types/node.dart' as _i4;
import '../types/tfchain_support/types/node_certification.dart' as _i14;
import '../types/tfchain_support/types/node_power.dart' as _i12;
import '../types/tfchain_support/types/power.dart' as _i17;
import '../types/tfchain_support/types/power_state.dart' as _i16;
import '../types/tfchain_support/types/public_config.dart' as _i25;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<int, _i2.Farm> _farms =
      const _i1.StorageMap<int, _i2.Farm>(
    prefix: 'TfgridModule',
    storage: 'Farms',
    valueCodec: _i2.Farm.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<int, List<int>> _nodesByFarmID =
      const _i1.StorageMap<int, List<int>>(
    prefix: 'TfgridModule',
    storage: 'NodesByFarmID',
    valueCodec: _i3.U32SequenceCodec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<List<int>, int> _farmIdByName =
      const _i1.StorageMap<List<int>, int>(
    prefix: 'TfgridModule',
    storage: 'FarmIdByName',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U8SequenceCodec.codec),
  );

  final _i1.StorageMap<int, List<int>> _farmPayoutV2AddressByFarmID =
      const _i1.StorageMap<int, List<int>>(
    prefix: 'TfgridModule',
    storage: 'FarmPayoutV2AddressByFarmID',
    valueCodec: _i3.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<int, _i4.Node> _nodes =
      const _i1.StorageMap<int, _i4.Node>(
    prefix: 'TfgridModule',
    storage: 'Nodes',
    valueCodec: _i4.Node.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<int, int> _nodeIdByTwinID =
      const _i1.StorageMap<int, int>(
    prefix: 'TfgridModule',
    storage: 'NodeIdByTwinID',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<int, _i5.Entity> _entities =
      const _i1.StorageMap<int, _i5.Entity>(
    prefix: 'TfgridModule',
    storage: 'Entities',
    valueCodec: _i5.Entity.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<_i6.AccountId32, int> _entityIdByAccountID =
      const _i1.StorageMap<_i6.AccountId32, int>(
    prefix: 'TfgridModule',
    storage: 'EntityIdByAccountID',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i6.AccountId32Codec()),
  );

  final _i1.StorageMap<List<int>, int> _entityIdByName =
      const _i1.StorageMap<List<int>, int>(
    prefix: 'TfgridModule',
    storage: 'EntityIdByName',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U8SequenceCodec.codec),
  );

  final _i1.StorageMap<int, _i7.Twin> _twins =
      const _i1.StorageMap<int, _i7.Twin>(
    prefix: 'TfgridModule',
    storage: 'Twins',
    valueCodec: _i7.Twin.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<_i6.AccountId32, int> _twinIdByAccountID =
      const _i1.StorageMap<_i6.AccountId32, int>(
    prefix: 'TfgridModule',
    storage: 'TwinIdByAccountID',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i6.AccountId32Codec()),
  );

  final _i1.StorageMap<int, _i6.AccountId32> _twinBoundedAccountID =
      const _i1.StorageMap<int, _i6.AccountId32>(
    prefix: 'TfgridModule',
    storage: 'TwinBoundedAccountID',
    valueCodec: _i6.AccountId32Codec(),
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<int, _i8.PricingPolicy> _pricingPolicies =
      const _i1.StorageMap<int, _i8.PricingPolicy>(
    prefix: 'TfgridModule',
    storage: 'PricingPolicies',
    valueCodec: _i8.PricingPolicy.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<List<int>, int> _pricingPolicyIdByName =
      const _i1.StorageMap<List<int>, int>(
    prefix: 'TfgridModule',
    storage: 'PricingPolicyIdByName',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U8SequenceCodec.codec),
  );

  final _i1.StorageMap<int, _i9.FarmingPolicy> _farmingPoliciesMap =
      const _i1.StorageMap<int, _i9.FarmingPolicy>(
    prefix: 'TfgridModule',
    storage: 'FarmingPoliciesMap',
    valueCodec: _i9.FarmingPolicy.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<_i6.AccountId32, List<_i10.TermsAndConditions>>
      _usersTermsAndConditions =
      const _i1.StorageMap<_i6.AccountId32, List<_i10.TermsAndConditions>>(
    prefix: 'TfgridModule',
    storage: 'UsersTermsAndConditions',
    valueCodec: _i3.SequenceCodec<_i10.TermsAndConditions>(
        _i10.TermsAndConditions.codec),
    hasher: _i1.StorageHasher.blake2b128Concat(_i6.AccountId32Codec()),
  );

  final _i1.StorageValue<List<_i6.AccountId32>> _allowedNodeCertifiers =
      const _i1.StorageValue<List<_i6.AccountId32>>(
    prefix: 'TfgridModule',
    storage: 'AllowedNodeCertifiers',
    valueCodec: _i3.SequenceCodec<_i6.AccountId32>(_i6.AccountId32Codec()),
  );

  final _i1.StorageValue<int> _connectionPrice = const _i1.StorageValue<int>(
    prefix: 'TfgridModule',
    storage: 'ConnectionPrice',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<int> _farmID = const _i1.StorageValue<int>(
    prefix: 'TfgridModule',
    storage: 'FarmID',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<int> _nodeID = const _i1.StorageValue<int>(
    prefix: 'TfgridModule',
    storage: 'NodeID',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<int> _entityID = const _i1.StorageValue<int>(
    prefix: 'TfgridModule',
    storage: 'EntityID',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<int> _twinID = const _i1.StorageValue<int>(
    prefix: 'TfgridModule',
    storage: 'TwinID',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<int> _pricingPolicyID = const _i1.StorageValue<int>(
    prefix: 'TfgridModule',
    storage: 'PricingPolicyID',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<int> _farmingPolicyID = const _i1.StorageValue<int>(
    prefix: 'TfgridModule',
    storage: 'FarmingPolicyID',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<_i11.StorageVersion> _palletVersion =
      const _i1.StorageValue<_i11.StorageVersion>(
    prefix: 'TfgridModule',
    storage: 'PalletVersion',
    valueCodec: _i11.StorageVersion.codec,
  );

  final _i1.StorageValue<List<int>> _zosVersion =
      const _i1.StorageValue<List<int>>(
    prefix: 'TfgridModule',
    storage: 'ZosVersion',
    valueCodec: _i3.U8SequenceCodec.codec,
  );

  final _i1.StorageMap<int, _i12.NodePower> _nodePower =
      const _i1.StorageMap<int, _i12.NodePower>(
    prefix: 'TfgridModule',
    storage: 'NodePower',
    valueCodec: _i12.NodePower.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  _i13.Future<_i2.Farm?> farms(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _farms.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _farms.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i13.Future<List<int>> nodesByFarmID(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _nodesByFarmID.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nodesByFarmID.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  _i13.Future<int> farmIdByName(
    List<int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _farmIdByName.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _farmIdByName.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i13.Future<List<int>> farmPayoutV2AddressByFarmID(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _farmPayoutV2AddressByFarmID.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _farmPayoutV2AddressByFarmID.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  _i13.Future<_i4.Node?> nodes(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _nodes.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nodes.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i13.Future<int> nodeIdByTwinID(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _nodeIdByTwinID.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nodeIdByTwinID.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i13.Future<_i5.Entity?> entities(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _entities.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _entities.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i13.Future<int?> entityIdByAccountID(
    _i6.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _entityIdByAccountID.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _entityIdByAccountID.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i13.Future<int> entityIdByName(
    List<int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _entityIdByName.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _entityIdByName.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i13.Future<_i7.Twin?> twins(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _twins.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _twins.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i13.Future<int?> twinIdByAccountID(
    _i6.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _twinIdByAccountID.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _twinIdByAccountID.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i13.Future<_i6.AccountId32?> twinBoundedAccountID(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _twinBoundedAccountID.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _twinBoundedAccountID.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i13.Future<_i8.PricingPolicy?> pricingPolicies(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pricingPolicies.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pricingPolicies.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i13.Future<int> pricingPolicyIdByName(
    List<int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pricingPolicyIdByName.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pricingPolicyIdByName.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i13.Future<_i9.FarmingPolicy> farmingPoliciesMap(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _farmingPoliciesMap.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _farmingPoliciesMap.decodeValue(bytes);
    }
    return _i9.FarmingPolicy(
      version: 0,
      id: 0,
      name: List<int>.filled(
        0,
        0,
        growable: true,
      ),
      cu: 0,
      su: 0,
      nu: 0,
      ipv4: 0,
      minimalUptime: 0,
      policyCreated: 0,
      policyEnd: 0,
      immutable: false,
      default_: false,
      nodeCertification: _i14.NodeCertification.diy,
      farmCertification: _i15.FarmCertification.notCertified,
    ); /* Default */
  }

  _i13.Future<List<_i10.TermsAndConditions>?> usersTermsAndConditions(
    _i6.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _usersTermsAndConditions.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _usersTermsAndConditions.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i13.Future<List<_i6.AccountId32>?> allowedNodeCertifiers(
      {_i1.BlockHash? at}) async {
    final hashedKey = _allowedNodeCertifiers.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _allowedNodeCertifiers.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i13.Future<int> connectionPrice({_i1.BlockHash? at}) async {
    final hashedKey = _connectionPrice.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _connectionPrice.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i13.Future<int> farmID({_i1.BlockHash? at}) async {
    final hashedKey = _farmID.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _farmID.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i13.Future<int> nodeID({_i1.BlockHash? at}) async {
    final hashedKey = _nodeID.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nodeID.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i13.Future<int> entityID({_i1.BlockHash? at}) async {
    final hashedKey = _entityID.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _entityID.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i13.Future<int> twinID({_i1.BlockHash? at}) async {
    final hashedKey = _twinID.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _twinID.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i13.Future<int> pricingPolicyID({_i1.BlockHash? at}) async {
    final hashedKey = _pricingPolicyID.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pricingPolicyID.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i13.Future<int> farmingPolicyID({_i1.BlockHash? at}) async {
    final hashedKey = _farmingPolicyID.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _farmingPolicyID.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  _i13.Future<_i11.StorageVersion> palletVersion({_i1.BlockHash? at}) async {
    final hashedKey = _palletVersion.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _palletVersion.decodeValue(bytes);
    }
    return _i11.StorageVersion.v17Struct; /* Default */
  }

  _i13.Future<List<int>> zosVersion({_i1.BlockHash? at}) async {
    final hashedKey = _zosVersion.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _zosVersion.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  _i13.Future<_i12.NodePower> nodePower(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _nodePower.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nodePower.decodeValue(bytes);
    }
    return _i12.NodePower(
      state: _i16.Up(),
      target: _i17.Power.up,
    ); /* Default */
  }

  /// Returns the storage key for `farms`.
  _i18.Uint8List farmsKey(int key1) {
    final hashedKey = _farms.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `nodesByFarmID`.
  _i18.Uint8List nodesByFarmIDKey(int key1) {
    final hashedKey = _nodesByFarmID.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `farmIdByName`.
  _i18.Uint8List farmIdByNameKey(List<int> key1) {
    final hashedKey = _farmIdByName.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `farmPayoutV2AddressByFarmID`.
  _i18.Uint8List farmPayoutV2AddressByFarmIDKey(int key1) {
    final hashedKey = _farmPayoutV2AddressByFarmID.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `nodes`.
  _i18.Uint8List nodesKey(int key1) {
    final hashedKey = _nodes.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `nodeIdByTwinID`.
  _i18.Uint8List nodeIdByTwinIDKey(int key1) {
    final hashedKey = _nodeIdByTwinID.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `entities`.
  _i18.Uint8List entitiesKey(int key1) {
    final hashedKey = _entities.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `entityIdByAccountID`.
  _i18.Uint8List entityIdByAccountIDKey(_i6.AccountId32 key1) {
    final hashedKey = _entityIdByAccountID.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `entityIdByName`.
  _i18.Uint8List entityIdByNameKey(List<int> key1) {
    final hashedKey = _entityIdByName.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `twins`.
  _i18.Uint8List twinsKey(int key1) {
    final hashedKey = _twins.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `twinIdByAccountID`.
  _i18.Uint8List twinIdByAccountIDKey(_i6.AccountId32 key1) {
    final hashedKey = _twinIdByAccountID.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `twinBoundedAccountID`.
  _i18.Uint8List twinBoundedAccountIDKey(int key1) {
    final hashedKey = _twinBoundedAccountID.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `pricingPolicies`.
  _i18.Uint8List pricingPoliciesKey(int key1) {
    final hashedKey = _pricingPolicies.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `pricingPolicyIdByName`.
  _i18.Uint8List pricingPolicyIdByNameKey(List<int> key1) {
    final hashedKey = _pricingPolicyIdByName.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `farmingPoliciesMap`.
  _i18.Uint8List farmingPoliciesMapKey(int key1) {
    final hashedKey = _farmingPoliciesMap.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `usersTermsAndConditions`.
  _i18.Uint8List usersTermsAndConditionsKey(_i6.AccountId32 key1) {
    final hashedKey = _usersTermsAndConditions.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `allowedNodeCertifiers`.
  _i18.Uint8List allowedNodeCertifiersKey() {
    final hashedKey = _allowedNodeCertifiers.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `connectionPrice`.
  _i18.Uint8List connectionPriceKey() {
    final hashedKey = _connectionPrice.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `farmID`.
  _i18.Uint8List farmIDKey() {
    final hashedKey = _farmID.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `nodeID`.
  _i18.Uint8List nodeIDKey() {
    final hashedKey = _nodeID.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `entityID`.
  _i18.Uint8List entityIDKey() {
    final hashedKey = _entityID.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `twinID`.
  _i18.Uint8List twinIDKey() {
    final hashedKey = _twinID.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `pricingPolicyID`.
  _i18.Uint8List pricingPolicyIDKey() {
    final hashedKey = _pricingPolicyID.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `farmingPolicyID`.
  _i18.Uint8List farmingPolicyIDKey() {
    final hashedKey = _farmingPolicyID.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `palletVersion`.
  _i18.Uint8List palletVersionKey() {
    final hashedKey = _palletVersion.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `zosVersion`.
  _i18.Uint8List zosVersionKey() {
    final hashedKey = _zosVersion.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `nodePower`.
  _i18.Uint8List nodePowerKey(int key1) {
    final hashedKey = _nodePower.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `farms`.
  _i18.Uint8List farmsMapPrefix() {
    final hashedKey = _farms.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `nodesByFarmID`.
  _i18.Uint8List nodesByFarmIDMapPrefix() {
    final hashedKey = _nodesByFarmID.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `farmIdByName`.
  _i18.Uint8List farmIdByNameMapPrefix() {
    final hashedKey = _farmIdByName.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `farmPayoutV2AddressByFarmID`.
  _i18.Uint8List farmPayoutV2AddressByFarmIDMapPrefix() {
    final hashedKey = _farmPayoutV2AddressByFarmID.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `nodes`.
  _i18.Uint8List nodesMapPrefix() {
    final hashedKey = _nodes.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `nodeIdByTwinID`.
  _i18.Uint8List nodeIdByTwinIDMapPrefix() {
    final hashedKey = _nodeIdByTwinID.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `entities`.
  _i18.Uint8List entitiesMapPrefix() {
    final hashedKey = _entities.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `entityIdByAccountID`.
  _i18.Uint8List entityIdByAccountIDMapPrefix() {
    final hashedKey = _entityIdByAccountID.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `entityIdByName`.
  _i18.Uint8List entityIdByNameMapPrefix() {
    final hashedKey = _entityIdByName.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `twins`.
  _i18.Uint8List twinsMapPrefix() {
    final hashedKey = _twins.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `twinIdByAccountID`.
  _i18.Uint8List twinIdByAccountIDMapPrefix() {
    final hashedKey = _twinIdByAccountID.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `twinBoundedAccountID`.
  _i18.Uint8List twinBoundedAccountIDMapPrefix() {
    final hashedKey = _twinBoundedAccountID.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `pricingPolicies`.
  _i18.Uint8List pricingPoliciesMapPrefix() {
    final hashedKey = _pricingPolicies.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `pricingPolicyIdByName`.
  _i18.Uint8List pricingPolicyIdByNameMapPrefix() {
    final hashedKey = _pricingPolicyIdByName.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `farmingPoliciesMap`.
  _i18.Uint8List farmingPoliciesMapMapPrefix() {
    final hashedKey = _farmingPoliciesMap.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `usersTermsAndConditions`.
  _i18.Uint8List usersTermsAndConditionsMapPrefix() {
    final hashedKey = _usersTermsAndConditions.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `nodePower`.
  _i18.Uint8List nodePowerMapPrefix() {
    final hashedKey = _nodePower.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::set_storage_version`].
  _i19.TfgridModule setStorageVersion({required _i11.StorageVersion version}) {
    return _i19.TfgridModule(_i20.SetStorageVersion(version: version));
  }

  /// See [`Pallet::create_farm`].
  _i19.TfgridModule createFarm({
    required List<int> name,
    required List<_i21.Ip4> publicIps,
  }) {
    return _i19.TfgridModule(_i20.CreateFarm(
      name: name,
      publicIps: publicIps,
    ));
  }

  /// See [`Pallet::update_farm`].
  _i19.TfgridModule updateFarm({
    required int farmId,
    required List<int> name,
  }) {
    return _i19.TfgridModule(_i20.UpdateFarm(
      farmId: farmId,
      name: name,
    ));
  }

  /// See [`Pallet::add_stellar_payout_v2address`].
  _i19.TfgridModule addStellarPayoutV2address({
    required int farmId,
    required List<int> stellarAddress,
  }) {
    return _i19.TfgridModule(_i20.AddStellarPayoutV2address(
      farmId: farmId,
      stellarAddress: stellarAddress,
    ));
  }

  /// See [`Pallet::set_farm_certification`].
  _i19.TfgridModule setFarmCertification({
    required int farmId,
    required _i15.FarmCertification certification,
  }) {
    return _i19.TfgridModule(_i20.SetFarmCertification(
      farmId: farmId,
      certification: certification,
    ));
  }

  /// See [`Pallet::add_farm_ip`].
  _i19.TfgridModule addFarmIp({
    required int farmId,
    required List<int> ip,
    required List<int> gw,
  }) {
    return _i19.TfgridModule(_i20.AddFarmIp(
      farmId: farmId,
      ip: ip,
      gw: gw,
    ));
  }

  /// See [`Pallet::remove_farm_ip`].
  _i19.TfgridModule removeFarmIp({
    required int farmId,
    required List<int> ip,
  }) {
    return _i19.TfgridModule(_i20.RemoveFarmIp(
      farmId: farmId,
      ip: ip,
    ));
  }

  /// See [`Pallet::create_node`].
  _i19.TfgridModule createNode({
    required int farmId,
    required _i22.Resources resources,
    required _i23.LocationInput location,
    required List<_i24.Interface> interfaces,
    required bool secureBoot,
    required bool virtualized,
    List<int>? serialNumber,
  }) {
    return _i19.TfgridModule(_i20.CreateNode(
      farmId: farmId,
      resources: resources,
      location: location,
      interfaces: interfaces,
      secureBoot: secureBoot,
      virtualized: virtualized,
      serialNumber: serialNumber,
    ));
  }

  /// See [`Pallet::update_node`].
  _i19.TfgridModule updateNode({
    required int nodeId,
    required int farmId,
    required _i22.Resources resources,
    required _i23.LocationInput location,
    required List<_i24.Interface> interfaces,
    required bool secureBoot,
    required bool virtualized,
    List<int>? serialNumber,
  }) {
    return _i19.TfgridModule(_i20.UpdateNode(
      nodeId: nodeId,
      farmId: farmId,
      resources: resources,
      location: location,
      interfaces: interfaces,
      secureBoot: secureBoot,
      virtualized: virtualized,
      serialNumber: serialNumber,
    ));
  }

  /// See [`Pallet::set_node_certification`].
  _i19.TfgridModule setNodeCertification({
    required int nodeId,
    required _i14.NodeCertification nodeCertification,
  }) {
    return _i19.TfgridModule(_i20.SetNodeCertification(
      nodeId: nodeId,
      nodeCertification: nodeCertification,
    ));
  }

  /// See [`Pallet::report_uptime`].
  _i19.TfgridModule reportUptime({required BigInt uptime}) {
    return _i19.TfgridModule(_i20.ReportUptime(uptime: uptime));
  }

  /// See [`Pallet::add_node_public_config`].
  _i19.TfgridModule addNodePublicConfig({
    required int farmId,
    required int nodeId,
    _i25.PublicConfig? publicConfig,
  }) {
    return _i19.TfgridModule(_i20.AddNodePublicConfig(
      farmId: farmId,
      nodeId: nodeId,
      publicConfig: publicConfig,
    ));
  }

  /// See [`Pallet::delete_node`].
  _i19.TfgridModule deleteNode({required int nodeId}) {
    return _i19.TfgridModule(_i20.DeleteNode(nodeId: nodeId));
  }

  /// See [`Pallet::create_entity`].
  _i19.TfgridModule createEntity({
    required _i6.AccountId32 target,
    required List<int> name,
    required List<int> country,
    required List<int> city,
    required List<int> signature,
  }) {
    return _i19.TfgridModule(_i20.CreateEntity(
      target: target,
      name: name,
      country: country,
      city: city,
      signature: signature,
    ));
  }

  /// See [`Pallet::update_entity`].
  _i19.TfgridModule updateEntity({
    required List<int> name,
    required List<int> country,
    required List<int> city,
  }) {
    return _i19.TfgridModule(_i20.UpdateEntity(
      name: name,
      country: country,
      city: city,
    ));
  }

  /// See [`Pallet::delete_entity`].
  _i19.TfgridModule deleteEntity() {
    return _i19.TfgridModule(_i20.DeleteEntity());
  }

  /// See [`Pallet::create_twin`].
  _i19.TfgridModule createTwin({
    List<int>? relay,
    List<int>? pk,
  }) {
    return _i19.TfgridModule(_i20.CreateTwin(
      relay: relay,
      pk: pk,
    ));
  }

  /// See [`Pallet::update_twin`].
  _i19.TfgridModule updateTwin({
    List<int>? relay,
    List<int>? pk,
  }) {
    return _i19.TfgridModule(_i20.UpdateTwin(
      relay: relay,
      pk: pk,
    ));
  }

  /// See [`Pallet::add_twin_entity`].
  _i19.TfgridModule addTwinEntity({
    required int twinId,
    required int entityId,
    required List<int> signature,
  }) {
    return _i19.TfgridModule(_i20.AddTwinEntity(
      twinId: twinId,
      entityId: entityId,
      signature: signature,
    ));
  }

  /// See [`Pallet::delete_twin_entity`].
  _i19.TfgridModule deleteTwinEntity({
    required int twinId,
    required int entityId,
  }) {
    return _i19.TfgridModule(_i20.DeleteTwinEntity(
      twinId: twinId,
      entityId: entityId,
    ));
  }

  /// See [`Pallet::create_pricing_policy`].
  _i19.TfgridModule createPricingPolicy({
    required List<int> name,
    required _i26.Policy su,
    required _i26.Policy cu,
    required _i26.Policy nu,
    required _i26.Policy ipu,
    required _i26.Policy uniqueName,
    required _i26.Policy domainName,
    required _i6.AccountId32 foundationAccount,
    required _i6.AccountId32 certifiedSalesAccount,
    required int discountForDedicationNodes,
  }) {
    return _i19.TfgridModule(_i20.CreatePricingPolicy(
      name: name,
      su: su,
      cu: cu,
      nu: nu,
      ipu: ipu,
      uniqueName: uniqueName,
      domainName: domainName,
      foundationAccount: foundationAccount,
      certifiedSalesAccount: certifiedSalesAccount,
      discountForDedicationNodes: discountForDedicationNodes,
    ));
  }

  /// See [`Pallet::update_pricing_policy`].
  _i19.TfgridModule updatePricingPolicy({
    required int pricingPolicyId,
    required List<int> name,
    required _i26.Policy su,
    required _i26.Policy cu,
    required _i26.Policy nu,
    required _i26.Policy ipu,
    required _i26.Policy uniqueName,
    required _i26.Policy domainName,
    required _i6.AccountId32 foundationAccount,
    required _i6.AccountId32 certifiedSalesAccount,
    required int discountForDedicationNodes,
  }) {
    return _i19.TfgridModule(_i20.UpdatePricingPolicy(
      pricingPolicyId: pricingPolicyId,
      name: name,
      su: su,
      cu: cu,
      nu: nu,
      ipu: ipu,
      uniqueName: uniqueName,
      domainName: domainName,
      foundationAccount: foundationAccount,
      certifiedSalesAccount: certifiedSalesAccount,
      discountForDedicationNodes: discountForDedicationNodes,
    ));
  }

  /// See [`Pallet::create_farming_policy`].
  _i19.TfgridModule createFarmingPolicy({
    required List<int> name,
    required int su,
    required int cu,
    required int nu,
    required int ipv4,
    required int minimalUptime,
    required int policyEnd,
    required bool immutable,
    required bool default_,
    required _i14.NodeCertification nodeCertification,
    required _i15.FarmCertification farmCertification,
  }) {
    return _i19.TfgridModule(_i20.CreateFarmingPolicy(
      name: name,
      su: su,
      cu: cu,
      nu: nu,
      ipv4: ipv4,
      minimalUptime: minimalUptime,
      policyEnd: policyEnd,
      immutable: immutable,
      default_: default_,
      nodeCertification: nodeCertification,
      farmCertification: farmCertification,
    ));
  }

  /// See [`Pallet::user_accept_tc`].
  _i19.TfgridModule userAcceptTc({
    required List<int> documentLink,
    required List<int> documentHash,
  }) {
    return _i19.TfgridModule(_i20.UserAcceptTc(
      documentLink: documentLink,
      documentHash: documentHash,
    ));
  }

  /// See [`Pallet::delete_node_farm`].
  _i19.TfgridModule deleteNodeFarm({required int nodeId}) {
    return _i19.TfgridModule(_i20.DeleteNodeFarm(nodeId: nodeId));
  }

  /// See [`Pallet::set_farm_dedicated`].
  _i19.TfgridModule setFarmDedicated({
    required int farmId,
    required bool dedicated,
  }) {
    return _i19.TfgridModule(_i20.SetFarmDedicated(
      farmId: farmId,
      dedicated: dedicated,
    ));
  }

  /// See [`Pallet::force_reset_farm_ip`].
  _i19.TfgridModule forceResetFarmIp({
    required int farmId,
    required List<int> ip,
  }) {
    return _i19.TfgridModule(_i20.ForceResetFarmIp(
      farmId: farmId,
      ip: ip,
    ));
  }

  /// See [`Pallet::set_connection_price`].
  _i19.TfgridModule setConnectionPrice({required int price}) {
    return _i19.TfgridModule(_i20.SetConnectionPrice(price: price));
  }

  /// See [`Pallet::add_node_certifier`].
  _i19.TfgridModule addNodeCertifier({required _i6.AccountId32 certifier}) {
    return _i19.TfgridModule(_i20.AddNodeCertifier(certifier: certifier));
  }

  /// See [`Pallet::remove_node_certifier`].
  _i19.TfgridModule removeNodeCertifier({required _i6.AccountId32 certifier}) {
    return _i19.TfgridModule(_i20.RemoveNodeCertifier(certifier: certifier));
  }

  /// See [`Pallet::update_farming_policy`].
  _i19.TfgridModule updateFarmingPolicy({
    required int farmingPolicyId,
    required List<int> name,
    required int su,
    required int cu,
    required int nu,
    required int ipv4,
    required int minimalUptime,
    required int policyEnd,
    required bool default_,
    required _i14.NodeCertification nodeCertification,
    required _i15.FarmCertification farmCertification,
  }) {
    return _i19.TfgridModule(_i20.UpdateFarmingPolicy(
      farmingPolicyId: farmingPolicyId,
      name: name,
      su: su,
      cu: cu,
      nu: nu,
      ipv4: ipv4,
      minimalUptime: minimalUptime,
      policyEnd: policyEnd,
      default_: default_,
      nodeCertification: nodeCertification,
      farmCertification: farmCertification,
    ));
  }

  /// See [`Pallet::attach_policy_to_farm`].
  _i19.TfgridModule attachPolicyToFarm({
    required int farmId,
    _i27.FarmingPolicyLimit? limits,
  }) {
    return _i19.TfgridModule(_i20.AttachPolicyToFarm(
      farmId: farmId,
      limits: limits,
    ));
  }

  /// See [`Pallet::set_zos_version`].
  _i19.TfgridModule setZosVersion({required List<int> zosVersion}) {
    return _i19.TfgridModule(_i20.SetZosVersion(zosVersion: zosVersion));
  }

  /// See [`Pallet::change_power_state`].
  _i19.TfgridModule changePowerState({required _i17.Power powerState}) {
    return _i19.TfgridModule(_i20.ChangePowerState(powerState: powerState));
  }

  /// See [`Pallet::change_power_target`].
  _i19.TfgridModule changePowerTarget({
    required int nodeId,
    required _i17.Power powerTarget,
  }) {
    return _i19.TfgridModule(_i20.ChangePowerTarget(
      nodeId: nodeId,
      powerTarget: powerTarget,
    ));
  }

  /// See [`Pallet::bond_twin_account`].
  _i19.TfgridModule bondTwinAccount({required int twinId}) {
    return _i19.TfgridModule(_i20.BondTwinAccount(twinId: twinId));
  }

  /// See [`Pallet::report_uptime_v2`].
  _i19.TfgridModule reportUptimeV2({
    required BigInt uptime,
    required BigInt timestampHint,
  }) {
    return _i19.TfgridModule(_i20.ReportUptimeV2(
      uptime: uptime,
      timestampHint: timestampHint,
    ));
  }
}

class Constants {
  Constants();

  final int maxFarmNameLength = 40;

  final int maxFarmPublicIps = 512;

  final int maxInterfacesLength = 10;

  final int maxInterfaceIpsLength = 10;

  final BigInt timestampHintDrift = BigInt.from(60);
}
