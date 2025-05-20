class StellarBalanceException implements Exception {
  final String message;
  final String? resultXdr;
  final bool isLowReserve;

  StellarBalanceException({
    required this.message,
    this.resultXdr,
    this.isLowReserve = false,
  });

  @override
  String toString() {
    if (resultXdr != null) {
      return 'StellarBalanceException: $message (XDR: $resultXdr)';
    }
    return 'StellarBalanceException: $message';
  }

  static StellarBalanceException fromOperationResult(
    List<String?>? operationCodes,
    String? resultXdr,
  ) {
    if (operationCodes?.contains('op_low_reserve') == true) {
      return StellarBalanceException(
        message: 'Transaction failed due to low reserve',
        resultXdr: resultXdr,
        isLowReserve: true,
      );
    }
    return StellarBalanceException(
      message: 'Transaction failed',
      resultXdr: resultXdr,
    );
  }
}
