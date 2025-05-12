// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i12;
import 'dart:typed_data' as _i14;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/pallet_smart_contract/grid_contract/name_contract_name.dart'
    as _i7;
import '../types/pallet_smart_contract/pallet/call.dart' as _i16;
import '../types/pallet_smart_contract/types/contract.dart' as _i2;
import '../types/pallet_smart_contract/types/contract_billing_information.dart'
    as _i4;
import '../types/pallet_smart_contract/types/contract_lock.dart' as _i6;
import '../types/pallet_smart_contract/types/contract_payment_state.dart'
    as _i11;
import '../types/pallet_smart_contract/types/contract_resources.dart' as _i5;
import '../types/pallet_smart_contract/types/nru_consumption.dart' as _i17;
import '../types/pallet_smart_contract/types/provider.dart' as _i18;
import '../types/pallet_smart_contract/types/service_contract.dart' as _i10;
import '../types/pallet_smart_contract/types/solution_provider.dart' as _i8;
import '../types/pallet_smart_contract/types/storage_version.dart' as _i9;
import '../types/sp_core/crypto/account_id32.dart' as _i19;
import '../types/tfchain_runtime/runtime_call.dart' as _i15;
import '../types/tfchain_support/resources/resources.dart' as _i13;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<BigInt, _i2.Contract> _contracts =
      const _i1.StorageMap<BigInt, _i2.Contract>(
    prefix: 'SmartContractModule',
    storage: 'Contracts',
    valueCodec: _i2.Contract.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U64Codec.codec),
  );

  final _i1.StorageMap<BigInt, _i4.ContractBillingInformation>
      _contractBillingInformationByID =
      const _i1.StorageMap<BigInt, _i4.ContractBillingInformation>(
    prefix: 'SmartContractModule',
    storage: 'ContractBillingInformationByID',
    valueCodec: _i4.ContractBillingInformation.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U64Codec.codec),
  );

  final _i1.StorageMap<BigInt, _i5.ContractResources> _nodeContractResources =
      const _i1.StorageMap<BigInt, _i5.ContractResources>(
    prefix: 'SmartContractModule',
    storage: 'NodeContractResources',
    valueCodec: _i5.ContractResources.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U64Codec.codec),
  );

  final _i1.StorageDoubleMap<int, List<int>, BigInt>
      _contractIDByNodeIDAndHash =
      const _i1.StorageDoubleMap<int, List<int>, BigInt>(
    prefix: 'SmartContractModule',
    storage: 'ContractIDByNodeIDAndHash',
    valueCodec: _i3.U64Codec.codec,
    hasher1: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.U8ArrayCodec(32)),
  );

  final _i1.StorageMap<int, List<BigInt>> _activeNodeContracts =
      const _i1.StorageMap<int, List<BigInt>>(
    prefix: 'SmartContractModule',
    storage: 'ActiveNodeContracts',
    valueCodec: _i3.U64SequenceCodec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<BigInt, List<BigInt>> _contractsToBillAt =
      const _i1.StorageMap<BigInt, List<BigInt>>(
    prefix: 'SmartContractModule',
    storage: 'ContractsToBillAt',
    valueCodec: _i3.U64SequenceCodec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U64Codec.codec),
  );

  final _i1.StorageMap<BigInt, _i6.ContractLock> _contractLock =
      const _i1.StorageMap<BigInt, _i6.ContractLock>(
    prefix: 'SmartContractModule',
    storage: 'ContractLock',
    valueCodec: _i6.ContractLock.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U64Codec.codec),
  );

  final _i1.StorageMap<_i7.NameContractName, BigInt>
      _contractIDByNameRegistration =
      const _i1.StorageMap<_i7.NameContractName, BigInt>(
    prefix: 'SmartContractModule',
    storage: 'ContractIDByNameRegistration',
    valueCodec: _i3.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i7.NameContractNameCodec()),
  );

  final _i1.StorageMap<int, BigInt> _activeRentContractForNode =
      const _i1.StorageMap<int, BigInt>(
    prefix: 'SmartContractModule',
    storage: 'ActiveRentContractForNode',
    valueCodec: _i3.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageValue<BigInt> _contractID = const _i1.StorageValue<BigInt>(
    prefix: 'SmartContractModule',
    storage: 'ContractID',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i1.StorageMap<BigInt, _i8.SolutionProvider> _solutionProviders =
      const _i1.StorageMap<BigInt, _i8.SolutionProvider>(
    prefix: 'SmartContractModule',
    storage: 'SolutionProviders',
    valueCodec: _i8.SolutionProvider.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U64Codec.codec),
  );

  final _i1.StorageValue<BigInt> _solutionProviderID =
      const _i1.StorageValue<BigInt>(
    prefix: 'SmartContractModule',
    storage: 'SolutionProviderID',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i1.StorageValue<_i9.StorageVersion> _palletVersion =
      const _i1.StorageValue<_i9.StorageVersion>(
    prefix: 'SmartContractModule',
    storage: 'PalletVersion',
    valueCodec: _i9.StorageVersion.codec,
  );

  final _i1.StorageValue<BigInt> _billingFrequency =
      const _i1.StorageValue<BigInt>(
    prefix: 'SmartContractModule',
    storage: 'BillingFrequency',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i1.StorageMap<BigInt, _i10.ServiceContract> _serviceContracts =
      const _i1.StorageMap<BigInt, _i10.ServiceContract>(
    prefix: 'SmartContractModule',
    storage: 'ServiceContracts',
    valueCodec: _i10.ServiceContract.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U64Codec.codec),
  );

  final _i1.StorageValue<BigInt> _serviceContractID =
      const _i1.StorageValue<BigInt>(
    prefix: 'SmartContractModule',
    storage: 'ServiceContractID',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i1.StorageValue<int> _currentMigrationStage =
      const _i1.StorageValue<int>(
    prefix: 'SmartContractModule',
    storage: 'CurrentMigrationStage',
    valueCodec: _i3.U8Codec.codec,
  );

  final _i1.StorageMap<int, BigInt> _dedicatedNodesExtraFee =
      const _i1.StorageMap<int, BigInt>(
    prefix: 'SmartContractModule',
    storage: 'DedicatedNodesExtraFee',
    valueCodec: _i3.U64Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<BigInt, _i11.ContractPaymentState>
      _contractPaymentState =
      const _i1.StorageMap<BigInt, _i11.ContractPaymentState>(
    prefix: 'SmartContractModule',
    storage: 'ContractPaymentState',
    valueCodec: _i11.ContractPaymentState.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U64Codec.codec),
  );

  _i12.Future<_i2.Contract?> contracts(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _contracts.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _contracts.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i12.Future<_i4.ContractBillingInformation> contractBillingInformationByID(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _contractBillingInformationByID.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _contractBillingInformationByID.decodeValue(bytes);
    }
    return _i4.ContractBillingInformation(
      previousNuReported: BigInt.zero,
      lastUpdated: BigInt.zero,
      amountUnbilled: BigInt.zero,
    ); /* Default */
  }

  _i12.Future<_i5.ContractResources> nodeContractResources(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _nodeContractResources.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nodeContractResources.decodeValue(bytes);
    }
    return _i5.ContractResources(
      contractId: BigInt.zero,
      used: _i13.Resources(
        hru: BigInt.zero,
        sru: BigInt.zero,
        cru: BigInt.zero,
        mru: BigInt.zero,
      ),
    ); /* Default */
  }

  _i12.Future<BigInt> contractIDByNodeIDAndHash(
    int key1,
    List<int> key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _contractIDByNodeIDAndHash.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _contractIDByNodeIDAndHash.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i12.Future<List<BigInt>> activeNodeContracts(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _activeNodeContracts.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _activeNodeContracts.decodeValue(bytes);
    }
    return List<BigInt>.filled(
      0,
      BigInt.zero,
      growable: true,
    ); /* Default */
  }

  _i12.Future<List<BigInt>> contractsToBillAt(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _contractsToBillAt.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _contractsToBillAt.decodeValue(bytes);
    }
    return List<BigInt>.filled(
      0,
      BigInt.zero,
      growable: true,
    ); /* Default */
  }

  _i12.Future<_i6.ContractLock> contractLock(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _contractLock.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _contractLock.decodeValue(bytes);
    }
    return _i6.ContractLock(
      amountLocked: BigInt.zero,
      extraAmountLocked: BigInt.zero,
      lockUpdated: BigInt.zero,
      cycles: 0,
    ); /* Default */
  }

  _i12.Future<BigInt> contractIDByNameRegistration(
    _i7.NameContractName key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _contractIDByNameRegistration.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _contractIDByNameRegistration.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i12.Future<BigInt?> activeRentContractForNode(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _activeRentContractForNode.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _activeRentContractForNode.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i12.Future<BigInt> contractID({_i1.BlockHash? at}) async {
    final hashedKey = _contractID.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _contractID.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i12.Future<_i8.SolutionProvider?> solutionProviders(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _solutionProviders.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _solutionProviders.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i12.Future<BigInt> solutionProviderID({_i1.BlockHash? at}) async {
    final hashedKey = _solutionProviderID.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _solutionProviderID.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i12.Future<_i9.StorageVersion> palletVersion({_i1.BlockHash? at}) async {
    final hashedKey = _palletVersion.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _palletVersion.decodeValue(bytes);
    }
    return _i9.StorageVersion.v10; /* Default */
  }

  _i12.Future<BigInt> billingFrequency({_i1.BlockHash? at}) async {
    final hashedKey = _billingFrequency.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _billingFrequency.decodeValue(bytes);
    }
    return BigInt.from(600); /* Default */
  }

  _i12.Future<_i10.ServiceContract?> serviceContracts(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _serviceContracts.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _serviceContracts.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i12.Future<BigInt> serviceContractID({_i1.BlockHash? at}) async {
    final hashedKey = _serviceContractID.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _serviceContractID.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// The current migration's stage, if any.
  _i12.Future<int?> currentMigrationStage({_i1.BlockHash? at}) async {
    final hashedKey = _currentMigrationStage.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentMigrationStage.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i12.Future<BigInt> dedicatedNodesExtraFee(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _dedicatedNodesExtraFee.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _dedicatedNodesExtraFee.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i12.Future<_i11.ContractPaymentState?> contractPaymentState(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _contractPaymentState.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _contractPaymentState.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `contracts`.
  _i14.Uint8List contractsKey(BigInt key1) {
    final hashedKey = _contracts.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `contractBillingInformationByID`.
  _i14.Uint8List contractBillingInformationByIDKey(BigInt key1) {
    final hashedKey = _contractBillingInformationByID.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `nodeContractResources`.
  _i14.Uint8List nodeContractResourcesKey(BigInt key1) {
    final hashedKey = _nodeContractResources.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `contractIDByNodeIDAndHash`.
  _i14.Uint8List contractIDByNodeIDAndHashKey(
    int key1,
    List<int> key2,
  ) {
    final hashedKey = _contractIDByNodeIDAndHash.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `activeNodeContracts`.
  _i14.Uint8List activeNodeContractsKey(int key1) {
    final hashedKey = _activeNodeContracts.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `contractsToBillAt`.
  _i14.Uint8List contractsToBillAtKey(BigInt key1) {
    final hashedKey = _contractsToBillAt.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `contractLock`.
  _i14.Uint8List contractLockKey(BigInt key1) {
    final hashedKey = _contractLock.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `contractIDByNameRegistration`.
  _i14.Uint8List contractIDByNameRegistrationKey(_i7.NameContractName key1) {
    final hashedKey = _contractIDByNameRegistration.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `activeRentContractForNode`.
  _i14.Uint8List activeRentContractForNodeKey(int key1) {
    final hashedKey = _activeRentContractForNode.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `contractID`.
  _i14.Uint8List contractIDKey() {
    final hashedKey = _contractID.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `solutionProviders`.
  _i14.Uint8List solutionProvidersKey(BigInt key1) {
    final hashedKey = _solutionProviders.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `solutionProviderID`.
  _i14.Uint8List solutionProviderIDKey() {
    final hashedKey = _solutionProviderID.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `palletVersion`.
  _i14.Uint8List palletVersionKey() {
    final hashedKey = _palletVersion.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `billingFrequency`.
  _i14.Uint8List billingFrequencyKey() {
    final hashedKey = _billingFrequency.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `serviceContracts`.
  _i14.Uint8List serviceContractsKey(BigInt key1) {
    final hashedKey = _serviceContracts.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `serviceContractID`.
  _i14.Uint8List serviceContractIDKey() {
    final hashedKey = _serviceContractID.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `currentMigrationStage`.
  _i14.Uint8List currentMigrationStageKey() {
    final hashedKey = _currentMigrationStage.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `dedicatedNodesExtraFee`.
  _i14.Uint8List dedicatedNodesExtraFeeKey(int key1) {
    final hashedKey = _dedicatedNodesExtraFee.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `contractPaymentState`.
  _i14.Uint8List contractPaymentStateKey(BigInt key1) {
    final hashedKey = _contractPaymentState.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `contracts`.
  _i14.Uint8List contractsMapPrefix() {
    final hashedKey = _contracts.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `contractBillingInformationByID`.
  _i14.Uint8List contractBillingInformationByIDMapPrefix() {
    final hashedKey = _contractBillingInformationByID.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `nodeContractResources`.
  _i14.Uint8List nodeContractResourcesMapPrefix() {
    final hashedKey = _nodeContractResources.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `contractIDByNodeIDAndHash`.
  _i14.Uint8List contractIDByNodeIDAndHashMapPrefix(int key1) {
    final hashedKey = _contractIDByNodeIDAndHash.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `activeNodeContracts`.
  _i14.Uint8List activeNodeContractsMapPrefix() {
    final hashedKey = _activeNodeContracts.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `contractsToBillAt`.
  _i14.Uint8List contractsToBillAtMapPrefix() {
    final hashedKey = _contractsToBillAt.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `contractLock`.
  _i14.Uint8List contractLockMapPrefix() {
    final hashedKey = _contractLock.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `contractIDByNameRegistration`.
  _i14.Uint8List contractIDByNameRegistrationMapPrefix() {
    final hashedKey = _contractIDByNameRegistration.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `activeRentContractForNode`.
  _i14.Uint8List activeRentContractForNodeMapPrefix() {
    final hashedKey = _activeRentContractForNode.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `solutionProviders`.
  _i14.Uint8List solutionProvidersMapPrefix() {
    final hashedKey = _solutionProviders.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `serviceContracts`.
  _i14.Uint8List serviceContractsMapPrefix() {
    final hashedKey = _serviceContracts.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `dedicatedNodesExtraFee`.
  _i14.Uint8List dedicatedNodesExtraFeeMapPrefix() {
    final hashedKey = _dedicatedNodesExtraFee.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `contractPaymentState`.
  _i14.Uint8List contractPaymentStateMapPrefix() {
    final hashedKey = _contractPaymentState.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::create_node_contract`].
  _i15.SmartContractModule createNodeContract({
    required int nodeId,
    required List<int> deploymentHash,
    required List<int> deploymentData,
    required int publicIps,
    BigInt? solutionProviderId,
  }) {
    return _i15.SmartContractModule(_i16.CreateNodeContract(
      nodeId: nodeId,
      deploymentHash: deploymentHash,
      deploymentData: deploymentData,
      publicIps: publicIps,
      solutionProviderId: solutionProviderId,
    ));
  }

  /// See [`Pallet::update_node_contract`].
  _i15.SmartContractModule updateNodeContract({
    required BigInt contractId,
    required List<int> deploymentHash,
    required List<int> deploymentData,
  }) {
    return _i15.SmartContractModule(_i16.UpdateNodeContract(
      contractId: contractId,
      deploymentHash: deploymentHash,
      deploymentData: deploymentData,
    ));
  }

  /// See [`Pallet::cancel_contract`].
  _i15.SmartContractModule cancelContract({required BigInt contractId}) {
    return _i15.SmartContractModule(
        _i16.CancelContract(contractId: contractId));
  }

  /// See [`Pallet::create_name_contract`].
  _i15.SmartContractModule createNameContract({required List<int> name}) {
    return _i15.SmartContractModule(_i16.CreateNameContract(name: name));
  }

  /// See [`Pallet::add_nru_reports`].
  _i15.SmartContractModule addNruReports(
      {required List<_i17.NruConsumption> reports}) {
    return _i15.SmartContractModule(_i16.AddNruReports(reports: reports));
  }

  /// See [`Pallet::report_contract_resources`].
  _i15.SmartContractModule reportContractResources(
      {required List<_i5.ContractResources> contractResources}) {
    return _i15.SmartContractModule(
        _i16.ReportContractResources(contractResources: contractResources));
  }

  /// See [`Pallet::create_rent_contract`].
  _i15.SmartContractModule createRentContract({
    required int nodeId,
    BigInt? solutionProviderId,
  }) {
    return _i15.SmartContractModule(_i16.CreateRentContract(
      nodeId: nodeId,
      solutionProviderId: solutionProviderId,
    ));
  }

  /// See [`Pallet::create_solution_provider`].
  _i15.SmartContractModule createSolutionProvider({
    required List<int> description,
    required List<int> link,
    required List<_i18.Provider> providers,
  }) {
    return _i15.SmartContractModule(_i16.CreateSolutionProvider(
      description: description,
      link: link,
      providers: providers,
    ));
  }

  /// See [`Pallet::approve_solution_provider`].
  _i15.SmartContractModule approveSolutionProvider({
    required BigInt solutionProviderId,
    required bool approve,
  }) {
    return _i15.SmartContractModule(_i16.ApproveSolutionProvider(
      solutionProviderId: solutionProviderId,
      approve: approve,
    ));
  }

  /// See [`Pallet::bill_contract_for_block`].
  _i15.SmartContractModule billContractForBlock({required BigInt contractId}) {
    return _i15.SmartContractModule(
        _i16.BillContractForBlock(contractId: contractId));
  }

  /// See [`Pallet::service_contract_create`].
  _i15.SmartContractModule serviceContractCreate({
    required _i19.AccountId32 serviceAccount,
    required _i19.AccountId32 consumerAccount,
  }) {
    return _i15.SmartContractModule(_i16.ServiceContractCreate(
      serviceAccount: serviceAccount,
      consumerAccount: consumerAccount,
    ));
  }

  /// See [`Pallet::service_contract_set_metadata`].
  _i15.SmartContractModule serviceContractSetMetadata({
    required BigInt serviceContractId,
    required List<int> metadata,
  }) {
    return _i15.SmartContractModule(_i16.ServiceContractSetMetadata(
      serviceContractId: serviceContractId,
      metadata: metadata,
    ));
  }

  /// See [`Pallet::service_contract_set_fees`].
  _i15.SmartContractModule serviceContractSetFees({
    required BigInt serviceContractId,
    required BigInt baseFee,
    required BigInt variableFee,
  }) {
    return _i15.SmartContractModule(_i16.ServiceContractSetFees(
      serviceContractId: serviceContractId,
      baseFee: baseFee,
      variableFee: variableFee,
    ));
  }

  /// See [`Pallet::service_contract_approve`].
  _i15.SmartContractModule serviceContractApprove(
      {required BigInt serviceContractId}) {
    return _i15.SmartContractModule(
        _i16.ServiceContractApprove(serviceContractId: serviceContractId));
  }

  /// See [`Pallet::service_contract_reject`].
  _i15.SmartContractModule serviceContractReject(
      {required BigInt serviceContractId}) {
    return _i15.SmartContractModule(
        _i16.ServiceContractReject(serviceContractId: serviceContractId));
  }

  /// See [`Pallet::service_contract_cancel`].
  _i15.SmartContractModule serviceContractCancel(
      {required BigInt serviceContractId}) {
    return _i15.SmartContractModule(
        _i16.ServiceContractCancel(serviceContractId: serviceContractId));
  }

  /// See [`Pallet::service_contract_bill`].
  _i15.SmartContractModule serviceContractBill({
    required BigInt serviceContractId,
    required BigInt variableAmount,
    required List<int> metadata,
  }) {
    return _i15.SmartContractModule(_i16.ServiceContractBill(
      serviceContractId: serviceContractId,
      variableAmount: variableAmount,
      metadata: metadata,
    ));
  }

  /// See [`Pallet::change_billing_frequency`].
  _i15.SmartContractModule changeBillingFrequency({required BigInt frequency}) {
    return _i15.SmartContractModule(
        _i16.ChangeBillingFrequency(frequency: frequency));
  }

  /// See [`Pallet::attach_solution_provider_id`].
  _i15.SmartContractModule attachSolutionProviderId({
    required BigInt contractId,
    required BigInt solutionProviderId,
  }) {
    return _i15.SmartContractModule(_i16.AttachSolutionProviderId(
      contractId: contractId,
      solutionProviderId: solutionProviderId,
    ));
  }

  /// See [`Pallet::set_dedicated_node_extra_fee`].
  _i15.SmartContractModule setDedicatedNodeExtraFee({
    required int nodeId,
    required BigInt extraFee,
  }) {
    return _i15.SmartContractModule(_i16.SetDedicatedNodeExtraFee(
      nodeId: nodeId,
      extraFee: extraFee,
    ));
  }

  /// See [`Pallet::cancel_contract_collective`].
  _i15.SmartContractModule cancelContractCollective(
      {required BigInt contractId}) {
    return _i15.SmartContractModule(
        _i16.CancelContractCollective(contractId: contractId));
  }
}

class Constants {
  Constants();

  final int maxNameContractNameLength = 64;

  final int maxDeploymentDataLength = 512;

  final int maxNodeContractPublicIps = 512;
}
