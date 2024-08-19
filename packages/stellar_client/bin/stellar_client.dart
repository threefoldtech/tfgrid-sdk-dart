import 'package:stellar_client/stellar_client.dart';

void main() async {
  final stellarClient = Client(NetworkType.TESTNET,
      "SCQPJVHZ6ZBWQAXNAGUPULZMD2XFYRQ3C4NOF5ZDPN7VWTDNDVZWY674");
  final res = await stellarClient.getTransactions();
  print(res);
  // await stellarClient.
}
