import 'package:stellar_client/models/balance.dart';
import 'package:stellar_client/stellar_client.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

Future<List<BalanceInfo>> getBalanceByAccountID(
    {required NetworkType network, required String accountId}) async {
  late StellarSDK _sdk;

  switch (network) {
    case NetworkType.TESTNET:
      _sdk = StellarSDK.TESTNET;
      break;
    case NetworkType.PUBLIC:
      _sdk = StellarSDK.PUBLIC;
      break;
  }

  List<BalanceInfo> balancesList = [];
  AccountResponse account = await _sdk.accounts.account(accountId);

  for (Balance balance in account.balances) {
    BalanceData balanceData;
    switch (balance.assetType) {
      case Asset.TYPE_NATIVE:
        balanceData = BalanceData(assetCode: 'XLM', balance: balance.balance);
        break;
      default:
        balanceData = BalanceData(
            assetCode: balance.assetCode!, balance: balance.balance);
    }
    balancesList.add(balanceData);
  }

  return balancesList;
}
