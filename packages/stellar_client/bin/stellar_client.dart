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

  final stellarClient = Client(NetworkType.PUBLIC,
      "SDSVD7L2OZXHW2PLARRJ34ZRJVBPMJWKVG4HNIEJKFHI35E3D3WWAUL4");
  print(stellarClient.accountId);
  print(stellarClient.secretSeed);

  // final response = await stellarClient.createOrderThroughThreefoldService(
  //     sellingAsset: 'TFT', buyingAsset: 'USDC', amount: '5', price: '0.9');

  // // await stellarClient.addTrustLineThroughThreefoldService('USDC');
  await stellarClient.createOrderThroughThreefoldService(
      sellingAsset: 'TFT', buyingAsset: 'USDC', amount: '3', price: '1');
  final balances = await stellarClient.getBalance();
  print(balances);
  // // final orderbook = await stellarClient.getOrderBook(
  // //     sellingAssetCode: 'TFT', buyingAssetCode: 'USDC');
  // await stellarClient.listMyOffers();
  // await stellarClient.getOrderBook(
  //     sellingAssetCode: 'USDC', buyingAssetCode: 'TFT');

  // final stellarClient = Client(NetworkType.TESTNET,
  //     "SA7C4BONCZUVAMPOAGKJMKIHN4FQYLRF6KVFEFUDQS6EBIOCLLNKQQCY");
  // print(stellarClient.accountId);
  // print(stellarClient.secretSeed);
//SCG2NAYKV2AS4N3INA3DMFXKLMBAOH2MN2TA3FSGF6FUUJXJQVDYPXRN
  // await stellarClient.activateThroughFriendBot(
  //     accountId: stellarClient.accountId);

  // await stellarClient.addTrustLine();
  // final balances = await stellarClient.getBalance();
  // print(balances);

  // await stellarClient.createOrder(
  //     sellingAsset: 'TFT', buyingAsset: 'USDC', amount: '3', price: '1');
  // await stellarClient.listMyOffers();
  // final res = await stellarClient.cancelOrder(
  //     sellingAsset: 'TFT', buyingAsset: 'USDC', offerId: '12910');
  // print(res.success);
  // await stellarClient.listMyOffers();
}
