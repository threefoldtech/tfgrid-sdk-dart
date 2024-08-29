class PaymentOperationDetails {
  final String from;
  final String to;
  final double amount;
  final String assetCode;
  final bool isSuccessful;

  PaymentOperationDetails({
    required this.from,
    required this.to,
    required this.amount,
    required this.assetCode,
    required this.isSuccessful,
  });

  @override
  String toString() {
    return 'PaymentOperationDetails(from: $from, to: $to, amount: $amount, assetCode: $assetCode, isSuccessful: $isSuccessful)';
  }
}

class CreateAccountOperationDetails {
  final String account;
  final double startingBalance;

  CreateAccountOperationDetails({
    required this.account,
    required this.startingBalance,
  });

  @override
  String toString() {
    return 'CreateAccountOperationDetails(account: $account, startingBalance: $startingBalance)';
  }
}

class PathPaymentStrictReceiveOperationDetails {
  final String from;
  final String to;
  final double sourceAmount;
  final String sourceAssetCode;
  final double destinationAmount;
  final String destinationAssetCode;

  PathPaymentStrictReceiveOperationDetails({
    required this.from,
    required this.to,
    required this.sourceAmount,
    required this.sourceAssetCode,
    required this.destinationAmount,
    required this.destinationAssetCode,
  });

  @override
  String toString() {
    return 'PathPaymentStrictReceiveOperationDetails(from: $from, to: $to, sourceAmount: $sourceAmount, sourceAssetCode: $sourceAssetCode, destinationAmount: $destinationAmount, destinationAssetCode: $destinationAssetCode)';
  }
}
