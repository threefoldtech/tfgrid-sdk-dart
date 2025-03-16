part of '../stellar_client.dart';

Future<BalanceData> getLiquidityPoolAssets(
    NetworkType network, String liquidityPoolId) async {
  late StellarSDK _sdk;
  late Uri liquidityPoolUri;
  late BalanceData balance;
  switch (network) {
    case NetworkType.TESTNET:
      _sdk = StellarSDK.TESTNET;
      break;
    default:
      _sdk = StellarSDK.PUBLIC;
  }
  try {
    if (network == Network.TESTNET) {
      liquidityPoolUri = Uri.parse(
          'https://horizon-testnet.stellar.org/liquidity_pools/$liquidityPoolId');
    } else {
      liquidityPoolUri = Uri.parse(
          'https://horizon.stellar.org/liquidity_pools/$liquidityPoolId');
    }
    LiquidityPoolResponse liquidityPool =
        await _sdk.liquidityPools.liquidityPool(liquidityPoolUri);

    for (var reserve in liquidityPool.reserves) {
      balance =
          BalanceData(assetCode: reserve.asset.type, balance: reserve.amount);
    }
    return balance;
  } catch (e) {
    throw Exception(e);
  }
}

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
  try {
    List<BalanceInfo> balancesList = [];
    AccountResponse account = await _sdk.accounts.account(accountId);
    for (Balance balance in account.balances) {
      BalanceData balanceData;
      switch (balance.assetType) {
        case Asset.TYPE_NATIVE:
          balanceData = BalanceData(assetCode: 'XLM', balance: balance.balance);
          break;
        case Asset.TYPE_POOL_SHARE:
          final b =
              await getLiquidityPoolAssets(network, balance.liquidityPoolId!);
          balanceData =
              BalanceData(assetCode: b.assetCode, balance: balance.balance);
        default:
          balanceData = BalanceData(
              assetCode: balance.assetCode!, balance: balance.balance);
      }
      balancesList.add(balanceData);
    }
    return balancesList;
  } catch (e) {
    throw Exception(e);
  }
}
