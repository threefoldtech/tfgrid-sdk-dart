part of '../stellar_client.dart';

class Client {
  final NetworkType _network;
  late StellarSDK _sdk;
  late KeyPair _keyPair;
  late currency.Currencies _currencies;
  late Map<String, String> _serviceUrls;
  late Map<String, String> _horizonServerUrls;
  late Network _stellarNetwork;

  String get accountId => _keyPair.accountId;
  String get secretSeed => _keyPair.secretSeed;
  Uint8List? get privateKey => _keyPair.privateKey;

  var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true),
    level: Level.debug,
    filter: ProductionFilter(),
  );

  Client(this._network, String secretSeed) {
    _keyPair = KeyPair.fromSecretSeed(secretSeed);
    _initialize();
  }

  factory Client.create(NetworkType network) {
    final keyPair = KeyPair.random();
    return Client(network, keyPair.secretSeed);
  }

  factory Client.fromSecretSeedHex(NetworkType network, String secretSeedHex) {
    final seed = Uint8List.fromList(hex.decode(secretSeedHex));
    final keyPair = KeyPair.fromSecretSeedList(seed);
    return Client(network, keyPair.secretSeed);
  }

  static Future<Client> fromMnemonic(
      NetworkType network, String mnemonic) async {
    Wallet wallet = await Wallet.from(mnemonic);
    final keyPair = await wallet.getKeyPair();
    return Client(network, keyPair.secretSeed);
  }

  void _initialize() {
    late final currency.Currency tft;
    late final currency.Currency usdc;
    _serviceUrls = {
      'PUBLIC': 'https://tokenservices.threefold.io/threefoldfoundation',
      'TESTNET': 'https://testnet.threefold.io/threefoldfoundation'
    };
    _horizonServerUrls = {
      'PUBLIC': 'https://horizon.stellar.org/',
      'TESTNET': 'https://horizon-testnet.stellar.org/'
    };

    switch (_network) {
      case NetworkType.TESTNET:
        _sdk = StellarSDK.TESTNET;
        _stellarNetwork = Network.TESTNET;
        tft = currency.Currency(
          assetCode: 'TFT',
          issuer: "GA47YZA3PKFUZMPLQ3B5F2E3CJIB57TGGU7SPCQT2WAEYKN766PWIMB3",
        );
        usdc = currency.Currency(
            assetCode: 'USDC',
            issuer: 'GBBD47IF6LWK7P7MDEVSCWR7DPUWV3NY3DTQEVFL4NAT4AQH3ZLLFLA5');
        break;
      case NetworkType.PUBLIC:
        _sdk = StellarSDK.PUBLIC;
        _stellarNetwork = Network.PUBLIC;
        tft = currency.Currency(
          assetCode: 'TFT',
          issuer: "GBOVQKJYHXRR3DX6NOX2RRYFRCUMSADGDESTDNBDS6CDVLGVESRTAC47",
        );
        usdc = currency.Currency(
            assetCode: 'USDC',
            issuer: 'GA5ZSEJYB37JRC5AVCIA5MOP4RHTM335X2KGX3IHOJAPP5RE34K4KZVN');
        break;
      default:
        throw Exception('Unsupported network type');
    }

    _currencies = currency.Currencies({
      'TFT': tft,
      'USDC': usdc,
      'XLM': currency.Currency(assetCode: 'XLM', issuer: "")
    });
  }

  Future<bool> activateThroughThreefoldService() async {
    Transaction? transaction = await _getActivationTransaction();
    if (transaction != null) {
      transaction.sign(_keyPair, _stellarNetwork);
      await _sdk.submitTransaction(transaction);
      logger.i("Account Activated Successfully.");
      logger.i("TFT Asset was added Successfully ");
      return true;
    } else {
      throw Exception("Failed to retrieve activation transaction.");
    }
  }

  Future<Transaction?> _getActivationTransaction() async {
    try {
      final response = await http.post(
        Uri.parse(
            '${_serviceUrls[_network.toString()]}/activation_service/activate_account'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'address': accountId}),
      );

      final data = jsonDecode(jsonDecode(response.body));
      String activationTransaction = data['activation_transaction'];

      XdrTransactionEnvelope xdrTxEnvelope =
          XdrTransactionEnvelope.fromEnvelopeXdrString(activationTransaction);

      Transaction transaction =
          Transaction.fromV1EnvelopeXdr(xdrTxEnvelope.v1!);

      return transaction;
    } catch (error) {
      throw Exception("Failed to activate: $error");
    }
  }

  Future<bool> activateThroughFriendBot({required String accountId}) async {
    if (_stellarNetwork != Network.TESTNET) {
      throw Exception("Network should be TEST");
    }
    try {
      bool funded = await FriendBot.fundTestAccount(accountId);
      if (funded) {
        logger.i("Account funded successfully");
      } else {
        logger.e("Failed to fund account");
      }
      return funded;
    } catch (error) {
      logger.e("Error while funding account: $error");
      return false;
    }
  }

  Future<bool> addTrustLine() async {
    bool allTrustlinesAdded = true;

    for (var entry in _currencies.currencies.entries) {
      String currencyCode = entry.key;
      currency.Currency currentCurrency = entry.value;
      if (currencyCode == 'XLM') {
        logger.i("Skipping trustline for native asset $currencyCode");
        continue;
      }
      logger.i(
          "Processing trustline for ${entry.key} with issuer ${entry.value.issuer}");

      String issuerAccountId = currentCurrency.issuer;
      Asset currencyAsset =
          AssetTypeCreditAlphaNum4(currentCurrency.assetCode, issuerAccountId);

      ChangeTrustOperationBuilder changeTrustOperation =
          ChangeTrustOperationBuilder(currencyAsset, "300000");

      final account = await _sdk.accounts.account(accountId);

      Transaction transaction = TransactionBuilder(account)
          .addOperation(changeTrustOperation.build())
          .build();
      transaction.sign(_keyPair, _stellarNetwork);

      SubmitTransactionResponse response =
          await _sdk.submitTransaction(transaction);

      if (!response.success) {
        logger.e("Failed to add trustline for $currencyCode");
        allTrustlinesAdded = false;
      } else {
        logger.i("Trustline for $currencyCode was added successfully");
      }
    }

    if (allTrustlinesAdded) {
      logger.i("All trustlines were added successfully");
      return true;
    } else {
      logger.e("One or more trustlines failed to be added");
      return false;
    }
  }

  Future<bool> transfer(
      {required String destinationAddress,
      required String amount,
      required String currency,
      String? memoText}) async {
    try {
      Transaction? transaction = await _buildTransaction(
          destinationAddress: destinationAddress,
          amount: amount,
          currency: currency,
          funded: false);

      transaction!.sign(_keyPair, _stellarNetwork);
      await _sdk.submitTransaction(transaction);
      logger.i("Transaction successful.");
      return true;
    } catch (error) {
      logger.e("Failed to send transaction: $error");
      return false;
    }
  }

  Future<bool> activateThroughActivationWallet(
      {required String activationWalletSecretSeed}) async {
    try {
      KeyPair walletKeyPair =
          KeyPair.fromSecretSeed(activationWalletSecretSeed);
      AccountResponse existingAccount =
          await _sdk.accounts.account(walletKeyPair.accountId);

      Transaction transaction = TransactionBuilder(existingAccount)
          .addOperation(CreateAccountOperationBuilder(accountId, "1").build())
          .build();

      transaction.sign(walletKeyPair, _stellarNetwork);

      await _sdk.submitTransaction(transaction);
      return true;
    } catch (error) {
      logger.e("Failed to create account $error");
      return false;
    }
  }

  // take asset code && issuer (optional)
  Future<bool> addTrustLineThroughThreefoldService(String asset_code) async {
    final asset = _currencies.currencies[asset_code];
    if (asset == null) {
      throw Exception("Asset $asset_code not supported");
    }

    try {
      final response = await http.post(
        Uri.parse(
            '${_serviceUrls[_network.toString()]}/activation_service/fund_trustline'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'asset': '${asset.assetCode}:${asset.issuer}',
          'address': accountId
        }),
      );

      final data = jsonDecode(response.body);
      String trustlineTransaction = data['addtrustline_transaction'];
      XdrTransactionEnvelope xdrTxEnvelope =
          XdrTransactionEnvelope.fromEnvelopeXdrString(trustlineTransaction);

      Transaction transaction =
          Transaction.fromV1EnvelopeXdr(xdrTxEnvelope.v1!);

      transaction.sign(_keyPair, _stellarNetwork);

      SubmitTransactionResponse response2 =
          await _sdk.submitTransaction(transaction);

      if (response2.success) {
        logger.i("Trustline for $asset_code added successfully.");
        return true;
      } else {
        logger.e("Failed to add trustline for $asset_code.");
        return false;
      }
    } catch (error) {
      throw Exception("Error funding trustline : $error");
    }
  }

  Future<TransactionData?> _fetchFundDetails(
      {required String assetCode}) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${_serviceUrls[_network.toString()]}/transactionfunding_service/conditions'),
        headers: {'Content-Type': 'application/json'},
      );

      final body = jsonDecode(response.body);
      Map<String, dynamic>? details;
      for (var item in body) {
        if (item['asset'].startsWith(assetCode)) {
          details = item;
          break;
        }
      }

      if (details != null) {
        TransactionData transactionData = TransactionData.fromJson(details);
        logger.i(transactionData);
        return transactionData;
      } else {
        logger.e('Failed to details for asset: ');
      }

      return null;
    } catch (error) {
      throw Exception("Failed to get fund details, $error");
    }
  }

  Future<Operation?> _makeFundPaymentOperation(
      {required String assetCode, required String issuer}) async {
    TransactionData? transactionData =
        await _fetchFundDetails(assetCode: assetCode);
    Asset asset = AssetTypeCreditAlphaNum4(assetCode, issuer);

    return PaymentOperationBuilder(
            transactionData!.feeAccountId, asset, transactionData.feeFixed)
        .build();
  }

  Future<Transaction?> _buildTransaction(
      {required String destinationAddress,
      required String amount,
      required String currency,
      String? memoText,
      required bool funded}) async {
    // check if I have enough balance
    final accountBalances = await this.getBalance();
    accountBalances.firstWhere(
        (b) =>
            b.assetCode == currency &&
            double.parse(b.balance) > double.parse(amount), orElse: () {
      if (accountBalances.contains(currency)) {
        throw Exception('Balance is not enough.');
      }
      throw Exception('Balance with asset code ${currency} not found.');
    });
    // check that receiver account exists
    final receiver = await _sdk.accounts.account(accountId);
    // check that asset exists
    var specificBalance = receiver.balances.firstWhere(
      (balance) => balance.assetCode == currency,
      orElse: () {
        throw Exception('Balance with asset code ${currency} not found.');
      },
    );

    final asset = _currencies.currencies[currency];
    if (asset == null) {
      throw Exception('${currency} not supported');
    }

    AccountResponse sender = await _sdk.accounts.account(accountId);
    Asset tftAsset = AssetTypeCreditAlphaNum4(asset.assetCode, asset.issuer);
    Transaction? transaction;

    if (funded) {
      Operation? paymentOperation = await _makeFundPaymentOperation(
          assetCode: asset.assetCode, issuer: asset.issuer);
      transaction = TransactionBuilder(sender)
          .addOperation(paymentOperation!)
          .addOperation(
              PaymentOperationBuilder(destinationAddress, tftAsset, amount)
                  .build())
          .addMemo(memoText != null ? Memo.text(memoText) : Memo.none())
          .build();
    } else {
      transaction = TransactionBuilder(sender)
          .addOperation(
              PaymentOperationBuilder(destinationAddress, tftAsset, amount)
                  .build())
          .addMemo(memoText != null ? Memo.text(memoText) : Memo.none())
          .build();
    }

    return transaction;
  }

  Future<void> transferThroughThreefoldService(
      {required String destinationAddress,
      required String amount,
      required String currency,
      String? memoText}) async {
    Transaction? fundedTransaction = await _buildTransaction(
        destinationAddress: destinationAddress,
        amount: amount,
        currency: currency,
        memoText: memoText,
        funded: true);

    fundedTransaction!.sign(_keyPair, _stellarNetwork);

    logger.i('Sending to');
    logger.i(
        '${_serviceUrls[_network.toString()]}/transactionfunding_service/fund_transaction');

    try {
      final response = await http.post(
        Uri.parse(
            '${_serviceUrls[_network.toString()]}/transactionfunding_service/fund_transaction'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'transaction': fundedTransaction.toEnvelopeXdrBase64()}),
      );

      logger.i(response.body);
    } catch (error) {
      throw Exception('Something went wrong! $error');
    }
  }

  Future<List<ITransaction>> getTransactions({String? assetCodeFilter}) async {
    Page<OperationResponse> payments = await _sdk.payments
        .forAccount(accountId)
        .order(RequestBuilderOrder.DESC)
        .execute();
    List<ITransaction> transactionDetails = [];

    if (payments.records.isNotEmpty) {
      for (OperationResponse response in payments.records) {
        if (response is PaymentOperationResponse) {
          final memoText = await this
              .getMemoText(response.links.transaction.toJson()["href"]);
          String assetCode = response.assetCode ?? 'XLM';
          if (assetCodeFilter == null || assetCode == assetCodeFilter) {
            final details = PaymentTransaction(
                hash: response.transactionHash,
                from: response.from,
                to: response.to,
                asset: response.assetCode.toString(),
                amount: response.amount,
                type: response.to == this.accountId
                    ? TransactionType.Receive
                    : TransactionType.Payment,
                status: response.transactionSuccessful,
                date: DateTime.parse(response.createdAt).toLocal().toString(),
                memo: memoText);

            transactionDetails.add(details);
          }
        } else {
          logger.i("Unhandled operation type: ${response.runtimeType}");
        }
      }
    } else {
      logger.i("No payment records found.");
    }
    return transactionDetails;
  }

  Future<List<BalanceInfo>> getBalance() async {
    try {
      List<BalanceInfo> balancesList =
          await getBalanceByAccountID(network: _network, accountId: accountId);
      return balancesList;
    } catch (error) {
      throw Exception('Could not get balance due to $error');
    }
  }

  Future<List<VestingAccount>?> getVestingAccounts() async {
    try {
      final response = await http.post(
        Uri.parse(
            '${_serviceUrls[_network.toString()]}/vesting_service/vesting_accounts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'owner_address': accountId}),
      );

      final body = jsonDecode(response.body);
      if (body['vesting_accounts'] is List &&
          body['vesting_accounts'].isEmpty) {
        logger.i("no vesting account found");
        return [];
      } else {
        List<VestingAccount> accountsList = [];

        for (var account in body['vesting_accounts']) {
          String address = account['address'];
          VestingAccount vestingAccount = VestingAccount.fromJson(account);

          accountsList.add(vestingAccount);
        }
        return accountsList;
      }
    } catch (error) {
      throw Exception('Could not create vestingAccount due to $error');
    }
  }

  Future<String> getMemoText(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      final body = jsonDecode(response.body);
      final memoText = body['memo'] ?? "";
      return memoText;
    } catch (e) {
      throw Exception("Couldn't get memo text due to ${e}");
    }
  }

  Future<SubmitTransactionResponse> createOrder(
      {required String sellingAssetCode,
      required String buyingAssetCode,
      required String amount,
      required String price,
      String? memo}) async {
    if (!_currencies.currencies.containsKey(sellingAssetCode)) {
      throw Exception('Sell asset $sellingAssetCode is not available.');
    }
    if (!_currencies.currencies.containsKey(buyingAssetCode)) {
      throw Exception('Buy asset $buyingAssetCode is not available.');
    }

    late final Asset sellAsset;
    late final Asset buyAsset;

    if (sellingAssetCode == 'XLM') {
      sellAsset = AssetTypeNative();
    } else {
      sellAsset = AssetTypeCreditAlphaNum4(
          _currencies.currencies[sellingAssetCode]!.assetCode,
          _currencies.currencies[sellingAssetCode]!.issuer);
    }
    if (buyingAssetCode == 'XLM') {
      buyAsset = AssetTypeNative();
    } else {
      buyAsset = AssetTypeCreditAlphaNum4(
          _currencies.currencies[buyingAssetCode]!.assetCode,
          _currencies.currencies[buyingAssetCode]!.issuer);
    }

    final ManageBuyOfferOperation buyOfferOperation =
        ManageBuyOfferOperationBuilder(sellAsset, buyAsset, amount, price)
            .build();

    final account = await _sdk.accounts.account(accountId);
    final balances = account.balances;

    try {
      final sellAssetBalance = balances.firstWhere(
        (balance) {
          if (sellingAssetCode == 'XLM' && balance.assetCode == null) {
            // Special case for XLM
            return true;
          } else {
            return balance.assetCode == sellingAssetCode;
          }
        },
        orElse: () {
          logger.e("Sell asset $sellingAssetCode not found in balances.");
          throw Exception('Insufficient balance in $sellingAssetCode');
        },
      );

      final double sellAmount = double.parse(amount);
      final double availableBalance = double.parse(sellAssetBalance.balance);

      if (sellAmount > availableBalance) {
        throw Exception(
            'Insufficient balance in $sellingAssetCode. Available: $availableBalance');
      }
    } catch (e) {
      logger.e("Error: ${e.toString()}");
      rethrow;
    }

    final Transaction transaction = TransactionBuilder(account)
        .addOperation(buyOfferOperation)
        .addMemo(memo != null ? Memo.text(memo) : Memo.none())
        .build();

    transaction.sign(_keyPair, _stellarNetwork);
    try {
      final SubmitTransactionResponse response =
          await _sdk.submitTransaction(transaction);
      if (!response.success) {
        logger.e('Transaction failed with result: ${response.resultXdr}');
      }
      return response;
    } catch (error) {
      throw Exception('Transaction failed due to: ${error.toString()}');
    }
  }

  Future<SubmitTransactionResponse> cancelOrder(
      {required String sellingAssetCode,
      required String buyingAssetCode,
      required String offerId,
      String? memo}) async {
    if (!_currencies.currencies.containsKey(sellingAssetCode)) {
      throw Exception('Sell asset $sellingAssetCode is not available.');
    }
    if (!_currencies.currencies.containsKey(buyingAssetCode)) {
      throw Exception('Buy asset $buyingAssetCode is not available.');
    }

    final offers = (await _sdk.offers.forAccount(accountId).execute()).records;
    final OfferResponse? targetOffer = offers.firstWhere(
      (offer) => offer.id == offerId,
      orElse: () => throw Exception(
          'Offer with ID $offerId not found in user\'s account.'),
    );

    late final Asset sellingAsset;
    late final Asset buyingAsset;

    if (sellingAssetCode == 'XLM') {
      sellingAsset = AssetTypeNative();
    } else {
      sellingAsset = AssetTypeCreditAlphaNum4(
          _currencies.currencies[sellingAssetCode]!.assetCode,
          _currencies.currencies[sellingAssetCode]!.issuer);
    }
    if (buyingAssetCode == 'XLM') {
      buyingAsset = AssetTypeNative();
    } else {
      buyingAsset = AssetTypeCreditAlphaNum4(
          _currencies.currencies[buyingAssetCode]!.assetCode,
          _currencies.currencies[buyingAssetCode]!.issuer);
    }

    final ManageBuyOfferOperation cancelOfferOperation =
        ManageBuyOfferOperationBuilder(sellingAsset, buyingAsset, '0', '1')
            .setOfferId(offerId)
            .build();

    final account = await _sdk.accounts.account(accountId);
    final Transaction transaction = TransactionBuilder(account)
        .addOperation(cancelOfferOperation)
        .addMemo(memo != null ? Memo.text(memo) : Memo.none())
        .build();
    transaction.sign(_keyPair, _stellarNetwork);
    try {
      final SubmitTransactionResponse response =
          await _sdk.submitTransaction(transaction);
      if (!response.success) {
        logger.e('Transaction failed with result: ${response.resultXdr}');
      }
      return response;
    } catch (error) {
      throw Exception('Transaction failed due to: ${error.toString()}');
    }
  }

  Future<SubmitTransactionResponse> updateOrder(
      {required String sellingAssetCode,
      required String buyingAssetCode,
      required String amount,
      required String price,
      required String offerId,
      String? memo}) async {
    if (!_currencies.currencies.containsKey(sellingAssetCode)) {
      throw Exception('Sell asset $sellingAssetCode is not available.');
    }
    if (!_currencies.currencies.containsKey(buyingAssetCode)) {
      throw Exception('Buy asset $buyingAssetCode is not available.');
    }

    final offers = (await _sdk.offers.forAccount(accountId).execute()).records;
    final OfferResponse? targetOffer = offers.firstWhere(
      (offer) => offer.id == offerId,
      orElse: () => throw Exception(
          'Offer with ID $offerId not found in user\'s account.'),
    );

    late final Asset sellingAsset;
    late final Asset buyingAsset;

    if (sellingAssetCode == 'XLM') {
      sellingAsset = AssetTypeNative();
    } else {
      sellingAsset = AssetTypeCreditAlphaNum4(
          _currencies.currencies[sellingAssetCode]!.assetCode,
          _currencies.currencies[sellingAssetCode]!.issuer);
    }
    if (buyingAssetCode == 'XLM') {
      buyingAsset = AssetTypeNative();
    } else {
      buyingAsset = AssetTypeCreditAlphaNum4(
          _currencies.currencies[buyingAssetCode]!.assetCode,
          _currencies.currencies[buyingAssetCode]!.issuer);
    }

    ManageBuyOfferOperation updateOfferOperation = ManageBuyOfferOperationBuilder(
      sellingAsset,
      buyingAsset,
      amount,
      price,
    ).setOfferId(offerId).build();

    final account = await _sdk.accounts.account(accountId);
    final Transaction transaction = TransactionBuilder(account)
        .addOperation(updateOfferOperation)
        .build();
    transaction.sign(_keyPair, _stellarNetwork);
    try {
      final SubmitTransactionResponse response =
          await _sdk.submitTransaction(transaction);
      if (!response.success) {
        logger.e('Transaction failed with result: ${response.resultXdr}');
      }
      return response;
    } catch (error) {
      throw Exception('Transaction failed due to: ${error.toString()}');
    }
  }

  Future<Stream<OrderBookResponse>> getOrderBook(
      {required String sellingAssetCode,
      required String buyingAssetCode}) async {
    if (!_currencies.currencies.containsKey(sellingAssetCode)) {
      throw Exception('Sell asset $sellingAssetCode is not available.');
    }
    if (!_currencies.currencies.containsKey(buyingAssetCode)) {
      throw Exception('Buy asset $buyingAssetCode is not available.');
    }
    http.Client httpClient = http.Client();
    Uri serverURI = Uri.parse(_horizonServerUrls[_network.toString()]!);
    late final Asset sellingAsset;
    late final Asset buyingAsset;

    if (sellingAssetCode == 'XLM') {
      sellingAsset = AssetTypeNative();
    } else {
      sellingAsset = AssetTypeCreditAlphaNum4(
          _currencies.currencies[sellingAssetCode]!.assetCode,
          _currencies.currencies[sellingAssetCode]!.issuer);
    }
    if (buyingAssetCode == 'XLM') {
      buyingAsset = AssetTypeNative();
    } else {
      buyingAsset = AssetTypeCreditAlphaNum4(
          _currencies.currencies[buyingAssetCode]!.assetCode,
          _currencies.currencies[buyingAssetCode]!.issuer);
    }

    OrderBookRequestBuilder orderBookRequest =
        OrderBookRequestBuilder(httpClient, serverURI)
          ..sellingAsset(sellingAsset)
          ..buyingAsset(buyingAsset);

    return await orderBookRequest.stream();
  }

  Future<List<OfferResponse>> listMyOffers() async {
    try {
      final offers = await _sdk.offers.forAccount(accountId).execute();

      if (offers.records.isEmpty) {
        logger.i('No offers found for account: $accountId');
        return [];
      }

      return offers.records;
    } catch (error) {
      throw Exception('Error listing offers for account $accountId: $error');
    }
  }
}
