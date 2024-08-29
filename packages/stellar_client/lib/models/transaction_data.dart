class TransactionData {
  final String asset;
  final String feeAccountId;
  final String feeFixed;

  TransactionData({
    required this.asset,
    required this.feeAccountId,
    required this.feeFixed,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      asset: json['asset'],
      feeAccountId: json['fee_account_id'],
      feeFixed: json['fee_fixed'],
    );
  }

  @override
  String toString() {
    return 'TransactionData{asset: $asset, feeAccountId: $feeAccountId, feeFixed: $feeFixed}';
  }
}
