import 'package:stellar_client/stellar_client.dart';

void main() async {
  // final stellarClient = Client.create(NetworkType.PUBLIC);
  // await stellarClient.activateThroughThreefoldService();

  // await stellarClient.transfer(
  //     destinationAddress: "destination-public-key",
  //     amount: "20",
  //     currency: "TFT",
  //     memoText: "Memo Text");

  // await stellarClient.getTransactions();

  final stellarClient = Client.create(NetworkType.TESTNET);
  await stellarClient.activateThroughFriendBot(
      accountId: stellarClient.accountId);
  await stellarClient.addTrustLine();
  final balances = await stellarClient.getBalance();
  print(balances);
  await stellarClient.listOffers();
  // await stellarClient.getOrderBook(
  //     sellingAssetCode: 'USDC', buyingAssetCode: 'TFT');
}
