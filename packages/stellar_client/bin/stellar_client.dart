import 'package:stellar_client/stellar_client.dart';

void main() async {
  final stellarClient = Client.create(NetworkType.TESTNET);
  await stellarClient.activateThroughThreefoldService();

  await stellarClient.checkVestingAccount();

  // await stellarClient.transfer(
  //     destinationAddress: "destination-public-key",
  //     amount: "20",
  //     currency: "TFT",
  //     memoText: "Memo Text");

  // await stellarClient.getTransactions();
}
