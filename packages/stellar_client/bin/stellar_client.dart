import 'package:stellar_client/stellar_client.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

void main() async {
  final stellarClient = Client(NetworkType.TESTNET);
  // final mnemonic = await Wallet.generate24WordsMnemonic();

  // receiver Account
  // GBMOW6C22NABBCZRB5V7OTBX56RG64TTV4QL3SECMY5M7FBZA6V46M2X

  final x = await stellarClient.loadAccountFromPublicKey(
      accountId: "GBMOW6C22NABBCZRB5V7OTBX56RG64TTV4QL3SECMY5M7FBZA6V46M2X");
  final balance = await stellarClient.getBalance();
  print(balance);
  await stellarClient.getTransactions();

  // final newPair =
  //     await stellarClient.createThreefoldAccount(mnemonic: mnemonic);
  // print(newPair!.accountId);

  // sender Account
  // GA6TSFIXQETAOQEHXZE7AOT7BQMHQIRPDLKFJ6M6DEYOMOLHOVWHDODC
  // final account = await stellarClient.loadAccountFromSecretSeed(
  //     secretSeed: "SCQPJVHZ6ZBWQAXNAGUPULZMD2XFYRQ3C4NOF5ZDPN7VWTDNDVZWY674");
  // final res = await stellarClient.getBalance();
  // print(res);

  // await stellarClient.sendTransaction(
  //     sourceKeyPair: account,
  //     destinationAddress:
  //         "GBMOW6C22NABBCZRB5V7OTBX56RG64TTV4QL3SECMY5M7FBZA6V46M2X",
  //     amount: "2",
  //     currency: "TFT",
  //     memoText: "");

  // await stellarClient.getTransactions();

  // TransactionResponse transaction = await stellarClient.sdk.transactions
  //     .transaction(
  //         "38f03f971de250d145e71f4e2ec0ff5d64e868bc7ea1894303d3d1fd092c4043");
  // print(transaction.toString());
  // print("Transaction Source Account: ${transaction.sourceAccount}");
  // print("Transaction Paging Token: ${transaction.pagingToken}");
  // print("Transaction Ledger: ${transaction.ledger}");
  // print("Transaction Created At: ${transaction.createdAt}");
  // print("Transaction Fee Charged: ${transaction.feeCharged}");
  // print("Transaction Operation Count: ${transaction.operationCount}");
  // print("Transaction Signatures: ${transaction.signatures}");
  // print("Transaction Envelope XDR: ${transaction.envelopeXdr}");
  // print("Transaction Result XDR: ${transaction.resultXdr}");
  // print("Transaction Result Meta XDR: ${transaction.resultMetaXdr}");

  // for (OperationResponse response in payments.records) {
  //   if (response is PaymentOperationResponse) {
  //     PaymentOperationResponse por = response as PaymentOperationResponse;
  //     if (por.transactionSuccessful) {
  //       print("Transaction hash: ${por.transactionHash}");
  //     }
  //   }
  // }

  // final account = await stellarClient.loadAccount(accountId: newPair.accountId);
  // for (var balance in account!.balances) {
  //   print(balance.assetCode);
  //   print(balance.balance);
  // }

  // await stellarClient.fundTrustLine("TFT");

  // final list = await stellarClient.getBalance();
  // print(list);

  // await stellarClient.getTransactions();

  // await stellarClient.fetchFundDetails(FetchFundDetailsOptions(
  //     assetCode: 'TFT',
  //     issuer: 'GBOVQKJYHXRR3DX6NOX2RRYFRCUMSADGDESTDNBDS6CDVLGVESRTAC47'));
}
