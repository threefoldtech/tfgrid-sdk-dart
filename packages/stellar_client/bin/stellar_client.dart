import 'package:stellar_client/stellar_client.dart';

void main() async {
  // final stellarClient = Client(NetworkType.TESTNET,
  //     "SCQPJVHZ6ZBWQAXNAGUPULZMD2XFYRQ3C4NOF5ZDPN7VWTDNDVZWY674");
  // final res = await stellarClient.getTransactions();
  // print(res);

  final stellarClient = Client.create(NetworkType.TESTNET);
  await stellarClient.activateThroughActivationWallet(
      activationWalletSecretSeed:
          "SCQPJVHZ6ZBWQAXNAGUPULZMD2XFYRQ3C4NOF5ZDPN7VWTDNDVZWY674");
  // final boolean = await stellarClient.activateThroughThreefoldService();

  // print(boolean);
  // final balance = await stellarClient.getBalance();
  // print(balance);
  // final boolean2 = await stellarClient.addTrustLineThroughThreefoldService("TFT");
  // print(boolean2);
  final balance2 = await stellarClient.getBalance();
  print(balance2);
}
