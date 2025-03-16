part of '../stellar_client.dart';

Future<List<BalanceInfo>> getBalanceByAccountID({
  required NetworkType network,
  required String accountId,
}) async {
  late StellarSDK _sdk;
  switch (network) {
    case NetworkType.TESTNET:
      _sdk = StellarSDK.TESTNET;
      break;
    case NetworkType.PUBLIC:
      _sdk = StellarSDK.PUBLIC;
      break;
  }
  try {
    List<BalanceInfo> balancesList = [];
    AccountResponse account = await _sdk.accounts.account(accountId);
    for (Balance balance in account.balances) {
      switch (balance.assetType) {
        case Asset.TYPE_NATIVE:
          balancesList.add(
            BalanceData(assetCode: 'XLM', balance: balance.balance),
          );
          break;
        case Asset.TYPE_POOL_SHARE:
          break;
        default:
          balancesList.add(
            BalanceData(
              assetCode: balance.assetCode!,
              balance: balance.balance,
            ),
          );
      }
    }
    return balancesList;
  } catch (e) {
    throw Exception(e);
  }
}
