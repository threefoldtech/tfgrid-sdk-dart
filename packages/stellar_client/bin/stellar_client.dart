import 'package:stellar_client/stellar_client.dart';

void main() async {
  final stellarClient = Client(NetworkType.PUBLIC,
      "SADVBQ6J6NHVT6X2QG5S73FMK4TUBGU342ORDWQTEY6LRAZXIYU5CWQ5");
  // await stellarClient.activateThroughThreefoldService();

  // await stellarClient.transfer(
  //     destinationAddress: "destination-public-key",
  //     amount: "20",
  //     currency: "TFT",
  //     memoText: "Memo Text");

  print(await stellarClient.getTransactions());
}
