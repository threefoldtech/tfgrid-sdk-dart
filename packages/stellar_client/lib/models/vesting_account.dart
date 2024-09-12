class VestingAccount {
  final String address;
  final double tft;

  VestingAccount({required this.address, required this.tft});

  factory VestingAccount.fromJson(Map<String, dynamic> json) {
    return VestingAccount(
      address: json['address'],
      tft: double.parse(json['TFT'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'TFT': tft,
    };
  }

  @override
  String toString() {
    return 'Address: $address, TFT: $tft';
  }
}
