// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:typed_data' as _i9;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/pallet_tft_bridge/pallet/call.dart' as _i11;
import '../types/pallet_tft_bridge/types/burn_transaction.dart' as _i5;
import '../types/pallet_tft_bridge/types/mint_transaction.dart' as _i4;
import '../types/pallet_tft_bridge/types/refund_transaction.dart' as _i6;
import '../types/pallet_tft_bridge/types/storage_version.dart' as _i7;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/tfchain_runtime/runtime_call.dart' as _i10;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.AccountId32>> _validators =
      const _i1.StorageValue<List<_i2.AccountId32>>(
    prefix: 'TFTBridgeModule',
    storage: 'Validators',
    valueCodec: _i3.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()),
  );

  final _i1.StorageValue<_i2.AccountId32> _feeAccount =
      const _i1.StorageValue<_i2.AccountId32>(
    prefix: 'TFTBridgeModule',
    storage: 'FeeAccount',
    valueCodec: _i2.AccountId32Codec(),
  );

  final _i1.StorageMap<List<int>, _i4.MintTransaction> _mintTransactions =
      const _i1.StorageMap<List<int>, _i4.MintTransaction>(
    prefix: 'TFTBridgeModule',
    storage: 'MintTransactions',
    valueCodec: _i4.MintTransaction.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U8SequenceCodec.codec),
  );

  final _i1.StorageMap<List<int>, _i4.MintTransaction>
      _executedMintTransactions =
      const _i1.StorageMap<List<int>, _i4.MintTransaction>(
    prefix: 'TFTBridgeModule',
    storage: 'ExecutedMintTransactions',
    valueCodec: _i4.MintTransaction.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U8SequenceCodec.codec),
  );

  final _i1.StorageMap<BigInt, _i5.BurnTransaction> _burnTransactions =
      const _i1.StorageMap<BigInt, _i5.BurnTransaction>(
    prefix: 'TFTBridgeModule',
    storage: 'BurnTransactions',
    valueCodec: _i5.BurnTransaction.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U64Codec.codec),
  );

  final _i1.StorageMap<BigInt, _i5.BurnTransaction> _executedBurnTransactions =
      const _i1.StorageMap<BigInt, _i5.BurnTransaction>(
    prefix: 'TFTBridgeModule',
    storage: 'ExecutedBurnTransactions',
    valueCodec: _i5.BurnTransaction.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U64Codec.codec),
  );

  final _i1.StorageMap<List<int>, _i6.RefundTransaction> _refundTransactions =
      const _i1.StorageMap<List<int>, _i6.RefundTransaction>(
    prefix: 'TFTBridgeModule',
    storage: 'RefundTransactions',
    valueCodec: _i6.RefundTransaction.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U8SequenceCodec.codec),
  );

  final _i1.StorageMap<List<int>, _i6.RefundTransaction>
      _executedRefundTransactions =
      const _i1.StorageMap<List<int>, _i6.RefundTransaction>(
    prefix: 'TFTBridgeModule',
    storage: 'ExecutedRefundTransactions',
    valueCodec: _i6.RefundTransaction.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.U8SequenceCodec.codec),
  );

  final _i1.StorageValue<BigInt> _burnTransactionID =
      const _i1.StorageValue<BigInt>(
    prefix: 'TFTBridgeModule',
    storage: 'BurnTransactionID',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i1.StorageValue<BigInt> _withdrawFee = const _i1.StorageValue<BigInt>(
    prefix: 'TFTBridgeModule',
    storage: 'WithdrawFee',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i1.StorageValue<BigInt> _depositFee = const _i1.StorageValue<BigInt>(
    prefix: 'TFTBridgeModule',
    storage: 'DepositFee',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i1.StorageValue<_i7.StorageVersion> _palletVersion =
      const _i1.StorageValue<_i7.StorageVersion>(
    prefix: 'TFTBridgeModule',
    storage: 'PalletVersion',
    valueCodec: _i7.StorageVersion.codec,
  );

  _i8.Future<List<_i2.AccountId32>> validators({_i1.BlockHash? at}) async {
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

  _i8.Future<_i2.AccountId32?> feeAccount({_i1.BlockHash? at}) async {
    final hashedKey = _feeAccount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _feeAccount.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i8.Future<_i4.MintTransaction?> mintTransactions(
    List<int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _mintTransactions.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _mintTransactions.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i8.Future<_i4.MintTransaction?> executedMintTransactions(
    List<int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _executedMintTransactions.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _executedMintTransactions.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i8.Future<_i5.BurnTransaction?> burnTransactions(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _burnTransactions.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _burnTransactions.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i8.Future<_i5.BurnTransaction?> executedBurnTransactions(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _executedBurnTransactions.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _executedBurnTransactions.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i8.Future<_i6.RefundTransaction> refundTransactions(
    List<int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _refundTransactions.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _refundTransactions.decodeValue(bytes);
    }
    return _i6.RefundTransaction(
      block: 0,
      amount: BigInt.zero,
      target: List<int>.filled(
        0,
        0,
        growable: true,
      ),
      txHash: List<int>.filled(
        0,
        0,
        growable: true,
      ),
      signatures: [],
      sequenceNumber: BigInt.zero,
    ); /* Default */
  }

  _i8.Future<_i6.RefundTransaction> executedRefundTransactions(
    List<int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _executedRefundTransactions.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _executedRefundTransactions.decodeValue(bytes);
    }
    return _i6.RefundTransaction(
      block: 0,
      amount: BigInt.zero,
      target: List<int>.filled(
        0,
        0,
        growable: true,
      ),
      txHash: List<int>.filled(
        0,
        0,
        growable: true,
      ),
      signatures: [],
      sequenceNumber: BigInt.zero,
    ); /* Default */
  }

  _i8.Future<BigInt> burnTransactionID({_i1.BlockHash? at}) async {
    final hashedKey = _burnTransactionID.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _burnTransactionID.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i8.Future<BigInt> withdrawFee({_i1.BlockHash? at}) async {
    final hashedKey = _withdrawFee.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _withdrawFee.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i8.Future<BigInt> depositFee({_i1.BlockHash? at}) async {
    final hashedKey = _depositFee.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _depositFee.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  _i8.Future<_i7.StorageVersion> palletVersion({_i1.BlockHash? at}) async {
    final hashedKey = _palletVersion.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _palletVersion.decodeValue(bytes);
    }
    return _i7.StorageVersion.v1; /* Default */
  }

  /// Returns the storage key for `validators`.
  _i9.Uint8List validatorsKey() {
    final hashedKey = _validators.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `feeAccount`.
  _i9.Uint8List feeAccountKey() {
    final hashedKey = _feeAccount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `mintTransactions`.
  _i9.Uint8List mintTransactionsKey(List<int> key1) {
    final hashedKey = _mintTransactions.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `executedMintTransactions`.
  _i9.Uint8List executedMintTransactionsKey(List<int> key1) {
    final hashedKey = _executedMintTransactions.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `burnTransactions`.
  _i9.Uint8List burnTransactionsKey(BigInt key1) {
    final hashedKey = _burnTransactions.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `executedBurnTransactions`.
  _i9.Uint8List executedBurnTransactionsKey(BigInt key1) {
    final hashedKey = _executedBurnTransactions.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `refundTransactions`.
  _i9.Uint8List refundTransactionsKey(List<int> key1) {
    final hashedKey = _refundTransactions.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `executedRefundTransactions`.
  _i9.Uint8List executedRefundTransactionsKey(List<int> key1) {
    final hashedKey = _executedRefundTransactions.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `burnTransactionID`.
  _i9.Uint8List burnTransactionIDKey() {
    final hashedKey = _burnTransactionID.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `withdrawFee`.
  _i9.Uint8List withdrawFeeKey() {
    final hashedKey = _withdrawFee.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `depositFee`.
  _i9.Uint8List depositFeeKey() {
    final hashedKey = _depositFee.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `palletVersion`.
  _i9.Uint8List palletVersionKey() {
    final hashedKey = _palletVersion.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `mintTransactions`.
  _i9.Uint8List mintTransactionsMapPrefix() {
    final hashedKey = _mintTransactions.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `executedMintTransactions`.
  _i9.Uint8List executedMintTransactionsMapPrefix() {
    final hashedKey = _executedMintTransactions.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `burnTransactions`.
  _i9.Uint8List burnTransactionsMapPrefix() {
    final hashedKey = _burnTransactions.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `executedBurnTransactions`.
  _i9.Uint8List executedBurnTransactionsMapPrefix() {
    final hashedKey = _executedBurnTransactions.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `refundTransactions`.
  _i9.Uint8List refundTransactionsMapPrefix() {
    final hashedKey = _refundTransactions.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `executedRefundTransactions`.
  _i9.Uint8List executedRefundTransactionsMapPrefix() {
    final hashedKey = _executedRefundTransactions.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// See [`Pallet::add_bridge_validator`].
  _i10.TFTBridgeModule addBridgeValidator({required _i2.AccountId32 target}) {
    return _i10.TFTBridgeModule(_i11.AddBridgeValidator(target: target));
  }

  /// See [`Pallet::remove_bridge_validator`].
  _i10.TFTBridgeModule removeBridgeValidator(
      {required _i2.AccountId32 target}) {
    return _i10.TFTBridgeModule(_i11.RemoveBridgeValidator(target: target));
  }

  /// See [`Pallet::set_fee_account`].
  _i10.TFTBridgeModule setFeeAccount({required _i2.AccountId32 target}) {
    return _i10.TFTBridgeModule(_i11.SetFeeAccount(target: target));
  }

  /// See [`Pallet::set_withdraw_fee`].
  _i10.TFTBridgeModule setWithdrawFee({required BigInt amount}) {
    return _i10.TFTBridgeModule(_i11.SetWithdrawFee(amount: amount));
  }

  /// See [`Pallet::set_deposit_fee`].
  _i10.TFTBridgeModule setDepositFee({required BigInt amount}) {
    return _i10.TFTBridgeModule(_i11.SetDepositFee(amount: amount));
  }

  /// See [`Pallet::swap_to_stellar`].
  _i10.TFTBridgeModule swapToStellar({
    required List<int> targetStellarAddress,
    required BigInt amount,
  }) {
    return _i10.TFTBridgeModule(_i11.SwapToStellar(
      targetStellarAddress: targetStellarAddress,
      amount: amount,
    ));
  }

  /// See [`Pallet::propose_or_vote_mint_transaction`].
  _i10.TFTBridgeModule proposeOrVoteMintTransaction({
    required List<int> transaction,
    required _i2.AccountId32 target,
    required BigInt amount,
  }) {
    return _i10.TFTBridgeModule(_i11.ProposeOrVoteMintTransaction(
      transaction: transaction,
      target: target,
      amount: amount,
    ));
  }

  /// See [`Pallet::propose_burn_transaction_or_add_sig`].
  _i10.TFTBridgeModule proposeBurnTransactionOrAddSig({
    required BigInt transactionId,
    required List<int> target,
    required BigInt amount,
    required List<int> signature,
    required List<int> stellarPubKey,
    required BigInt sequenceNumber,
  }) {
    return _i10.TFTBridgeModule(_i11.ProposeBurnTransactionOrAddSig(
      transactionId: transactionId,
      target: target,
      amount: amount,
      signature: signature,
      stellarPubKey: stellarPubKey,
      sequenceNumber: sequenceNumber,
    ));
  }

  /// See [`Pallet::set_burn_transaction_executed`].
  _i10.TFTBridgeModule setBurnTransactionExecuted(
      {required BigInt transactionId}) {
    return _i10.TFTBridgeModule(
        _i11.SetBurnTransactionExecuted(transactionId: transactionId));
  }

  /// See [`Pallet::create_refund_transaction_or_add_sig`].
  _i10.TFTBridgeModule createRefundTransactionOrAddSig({
    required List<int> txHash,
    required List<int> target,
    required BigInt amount,
    required List<int> signature,
    required List<int> stellarPubKey,
    required BigInt sequenceNumber,
  }) {
    return _i10.TFTBridgeModule(_i11.CreateRefundTransactionOrAddSig(
      txHash: txHash,
      target: target,
      amount: amount,
      signature: signature,
      stellarPubKey: stellarPubKey,
      sequenceNumber: sequenceNumber,
    ));
  }

  /// See [`Pallet::set_refund_transaction_executed`].
  _i10.TFTBridgeModule setRefundTransactionExecuted(
      {required List<int> txHash}) {
    return _i10.TFTBridgeModule(
        _i11.SetRefundTransactionExecuted(txHash: txHash));
  }
}
