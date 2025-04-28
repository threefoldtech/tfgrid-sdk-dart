part of '../stellar_client.dart';

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

Future<List<TradeResponse>> getTradingHistory(
    {required NetworkType network, required String accountId}) async {
  try {
    late StellarSDK _sdk;
    List<TradeResponse> allTrades = [];

    switch (network) {
      case NetworkType.TESTNET:
        _sdk = StellarSDK.TESTNET;
        break;
      case NetworkType.PUBLIC:
        _sdk = StellarSDK.PUBLIC;
        break;
    }

    Page<TradeResponse>? tradesPage =
        await _sdk.trades.forAccount(accountId).execute();
    final httpClient = http.Client();
    try {
      while (tradesPage != null) {
        allTrades.addAll(tradesPage.records);
        tradesPage = await tradesPage.getNextPage(httpClient);
        if (tradesPage == null || tradesPage.records.isEmpty) {
          break;
        }
      }
    } finally {
      httpClient.close();
    }
    return allTrades;
  } catch (e) {
    throw Exception('Failed to fetch trading history: ${e.toString()}');
  }
}

/// Retrieves the order book for a given asset pair on the Stellar network.
///
/// This function returns a stream of `OrderBookResponse`, which provides
/// real-time updates on buy and sell orders for the specified asset pair.
///
/// ### Understanding Stellar Order Representation:
/// - **Price (`OrderBookResponse.asks[].price` & `OrderBookResponse.bids[].price`)**:
///   Stellar stores price as `buying / selling`, meaning the displayed price
///   is the **inverse** of the price provided when creating an order.
/// - **Amount (`OrderBookResponse.asks[].amount`)**:
///   This represents the total amount of the **selling asset** available in the order book.
///
/// ### Conversion Formula:
/// ```
/// Total selling amount = Buying amount * Price
/// Stored price = 1 / Provided price
/// ```
///
/// ### Example:
/// #### **Creating an Order**
/// ```dart
/// await stellarClient.createOrder(
///     sellingAssetCode: 'XLM',
///     buyingAssetCode: 'TFT',
///     amount: '2',     // Buying 2 TFT
///     price: '0.1');   // 1 XLM = 0.1 TFT
/// ```
///
/// #### **Retrieved Order Book Entry**
/// ```dart
/// OrderBookResponse {
///   asks: [
///     {
///       amount: "0.2",   // Total selling amount = 2 * 0.1 = 0.2 XLM
///       price: "10.0"    // Inverted: 1 / 0.1 = 10 XLM per TFT
///     }
///   ]
/// }
/// ```
///
/// **Key Takeaways:**
/// - `OrderBookResponse.asks[].amount` = **Total amount of the selling asset**.
/// - `OrderBookResponse.asks[].price` = **Inverse of the provided price**.
Future<Stream<OrderBookResponse>> getOrderBook(
    {required String horizonUrl,
    required Asset sellingAsset,
    required Asset buyingAsset}) async {
  http.Client httpClient = http.Client();
  Uri serverURI = Uri.parse(horizonUrl);

  OrderBookRequestBuilder orderBookRequest =
      OrderBookRequestBuilder(httpClient, serverURI)
        ..sellingAsset(sellingAsset)
        ..buyingAsset(buyingAsset);

  return await orderBookRequest.stream();
}
