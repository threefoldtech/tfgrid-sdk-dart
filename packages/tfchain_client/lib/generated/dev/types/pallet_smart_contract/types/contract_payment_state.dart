// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class ContractPaymentState {
  const ContractPaymentState({
    required this.standardReserve,
    required this.additionalReserve,
    required this.standardOverdraft,
    required this.additionalOverdraft,
    required this.lastUpdatedSeconds,
    required this.cycles,
  });

  factory ContractPaymentState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BalanceOf
  final BigInt standardReserve;

  /// BalanceOf
  final BigInt additionalReserve;

  /// BalanceOf
  final BigInt standardOverdraft;

  /// BalanceOf
  final BigInt additionalOverdraft;

  /// u64
  final BigInt lastUpdatedSeconds;

  /// u16
  final int cycles;

  static const $ContractPaymentStateCodec codec = $ContractPaymentStateCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'standardReserve': standardReserve,
        'additionalReserve': additionalReserve,
        'standardOverdraft': standardOverdraft,
        'additionalOverdraft': additionalOverdraft,
        'lastUpdatedSeconds': lastUpdatedSeconds,
        'cycles': cycles,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ContractPaymentState &&
          other.standardReserve == standardReserve &&
          other.additionalReserve == additionalReserve &&
          other.standardOverdraft == standardOverdraft &&
          other.additionalOverdraft == additionalOverdraft &&
          other.lastUpdatedSeconds == lastUpdatedSeconds &&
          other.cycles == cycles;

  @override
  int get hashCode => Object.hash(
        standardReserve,
        additionalReserve,
        standardOverdraft,
        additionalOverdraft,
        lastUpdatedSeconds,
        cycles,
      );
}

class $ContractPaymentStateCodec with _i1.Codec<ContractPaymentState> {
  const $ContractPaymentStateCodec();

  @override
  void encodeTo(
    ContractPaymentState obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.standardReserve,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.additionalReserve,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.standardOverdraft,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.additionalOverdraft,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.lastUpdatedSeconds,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      obj.cycles,
      output,
    );
  }

  @override
  ContractPaymentState decode(_i1.Input input) {
    return ContractPaymentState(
      standardReserve: _i1.U128Codec.codec.decode(input),
      additionalReserve: _i1.U128Codec.codec.decode(input),
      standardOverdraft: _i1.U128Codec.codec.decode(input),
      additionalOverdraft: _i1.U128Codec.codec.decode(input),
      lastUpdatedSeconds: _i1.U64Codec.codec.decode(input),
      cycles: _i1.U16Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ContractPaymentState obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.standardReserve);
    size = size + _i1.U128Codec.codec.sizeHint(obj.additionalReserve);
    size = size + _i1.U128Codec.codec.sizeHint(obj.standardOverdraft);
    size = size + _i1.U128Codec.codec.sizeHint(obj.additionalOverdraft);
    size = size + _i1.U64Codec.codec.sizeHint(obj.lastUpdatedSeconds);
    size = size + _i1.U16Codec.codec.sizeHint(obj.cycles);
    return size;
  }
}
