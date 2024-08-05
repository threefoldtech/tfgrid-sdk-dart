// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import 'stellar_signature.dart' as _i2;

class RefundTransaction {
  const RefundTransaction({
    required this.block,
    required this.amount,
    required this.target,
    required this.txHash,
    required this.signatures,
    required this.sequenceNumber,
  });

  factory RefundTransaction.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BlockNumber
  final int block;

  /// u64
  final BigInt amount;

  /// Vec<u8>
  final List<int> target;

  /// Vec<u8>
  final List<int> txHash;

  /// Vec<StellarSignature>
  final List<_i2.StellarSignature> signatures;

  /// u64
  final BigInt sequenceNumber;

  static const $RefundTransactionCodec codec = $RefundTransactionCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'block': block,
        'amount': amount,
        'target': target,
        'txHash': txHash,
        'signatures': signatures.map((value) => value.toJson()).toList(),
        'sequenceNumber': sequenceNumber,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RefundTransaction &&
          other.block == block &&
          other.amount == amount &&
          _i4.listsEqual(
            other.target,
            target,
          ) &&
          _i4.listsEqual(
            other.txHash,
            txHash,
          ) &&
          _i4.listsEqual(
            other.signatures,
            signatures,
          ) &&
          other.sequenceNumber == sequenceNumber;

  @override
  int get hashCode => Object.hash(
        block,
        amount,
        target,
        txHash,
        signatures,
        sequenceNumber,
      );
}

class $RefundTransactionCodec with _i1.Codec<RefundTransaction> {
  const $RefundTransactionCodec();

  @override
  void encodeTo(
    RefundTransaction obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.block,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.amount,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.target,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.txHash,
      output,
    );
    const _i1.SequenceCodec<_i2.StellarSignature>(_i2.StellarSignature.codec)
        .encodeTo(
      obj.signatures,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.sequenceNumber,
      output,
    );
  }

  @override
  RefundTransaction decode(_i1.Input input) {
    return RefundTransaction(
      block: _i1.U32Codec.codec.decode(input),
      amount: _i1.U64Codec.codec.decode(input),
      target: _i1.U8SequenceCodec.codec.decode(input),
      txHash: _i1.U8SequenceCodec.codec.decode(input),
      signatures: const _i1.SequenceCodec<_i2.StellarSignature>(
              _i2.StellarSignature.codec)
          .decode(input),
      sequenceNumber: _i1.U64Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(RefundTransaction obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.block);
    size = size + _i1.U64Codec.codec.sizeHint(obj.amount);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.target);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.txHash);
    size = size +
        const _i1.SequenceCodec<_i2.StellarSignature>(
                _i2.StellarSignature.codec)
            .sizeHint(obj.signatures);
    size = size + _i1.U64Codec.codec.sizeHint(obj.sequenceNumber);
    return size;
  }
}
