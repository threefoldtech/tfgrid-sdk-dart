part of '../stellar_client.dart';

class Client {
  final NetworkType _network;
  late StellarSDK _sdk;
  late KeyPair _keyPair;
  late currency.Currencies _currencies;
  late Map<String, String> _serviceUrls;
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
    ),
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

  /// Adds trustline for all non-native assets in the `_currencies.currencies` map.
  ///
  /// Trustlines are required to hold non-native assets on a Stellar account.
  /// This function iterates over all available currencies and attempts to
  /// establish trustlines for each, except for the native asset (`XLM`).
  ///
  /// **Note:** Adding trustline requires having XLM in the account
  ///
  /// ### Returns:
  /// - `true` if all trustlines were successfully added.
  /// - `false` if one or more trustlines failed.
  Future<bool> addConfiguredTrustlines() async {
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

  /// Transfers a specified amount of currency to a destination address.
  ///
  /// This function builds a Stellar transaction to send funds from the current account
  /// to a given recipient. It supports optional memo fields for additional transaction details.
  /// **Note:** Transfer requires having XLM in the account
  Future<bool> transfer(
      {required String destinationAddress,
      required String amount,
      required String currency,
      String? memoText,
      Uint8List? memoHash}) async {
    try {
      Transaction? transaction = await _buildTransaction(
          destinationAddress: destinationAddress,
          amount: amount,
          currency: currency,
          memoText: memoText,
          memoHash: memoHash,
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
      Uint8List? memoHash,
      required bool funded}) async {
    // check if I have enough balance
    final accountBalances = await this.getBalance();
    Memo memo = Memo.none();

    if (memoText != null) {
      memo = Memo.text(memoText);
    } else if (memoHash != null) {
      memo = Memo.hash(memoHash);
    }

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
          .addMemo(memo)
          .build();
    } else {
      transaction = TransactionBuilder(sender)
          .addOperation(
              PaymentOperationBuilder(destinationAddress, tftAsset, amount)
                  .build())
          .addMemo(memo)
          .build();
    }

    return transaction;
  }

  Future<void> transferThroughThreefoldService(
      {required String destinationAddress,
      required String amount,
      required String currency,
      String? memoText,
      Uint8List? memoHash}) async {
    Transaction? fundedTransaction = await _buildTransaction(
        destinationAddress: destinationAddress,
        amount: amount,
        currency: currency,
        memoText: memoText,
        memoHash: memoHash,
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

  Stream<ITransaction> getTransactions({
    String? assetCodeFilter,
    int limit = 10,
    String? pagingToken,
  }) async* {
    String? currentCursor = pagingToken;
    int count = 0;

    try {
      while (count < limit) {
        final request = _sdk.payments
            .forAccount(accountId)
            .order(RequestBuilderOrder.DESC)
            .limit(limit)
            .cursor(currentCursor ?? '');

        final page = await request.execute();
        if (page.records.isEmpty) break;

        final tempList = <_TempTx>[];

        for (final response in page.records) {
          if (response is PaymentOperationResponse &&
              (assetCodeFilter == null ||
                  response.assetCode == assetCodeFilter)) {
            tempList.add(_TempTx(
              response.links.transaction.toJson()["href"],
              response,
            ));
            if (++count >= limit) break;
          }
        }

        if (tempList.isEmpty) break;

        currentCursor = tempList.last.response.pagingToken;

        final memoList = await Future.wait(
          tempList.map((tx) => getMemoText(tx.href)),
        );

        for (var i = 0; i < tempList.length; i++) {
          final tx = tempList[i].response;
          yield PaymentTransaction(
            pagingToken: tx.pagingToken,
            hash: tx.transactionHash,
            from: tx.from,
            to: tx.to,
            asset: tx.assetCode ?? 'XLM',
            amount: tx.amount,
            type: tx.to == accountId
                ? TransactionType.Receive
                : TransactionType.Payment,
            status: tx.transactionSuccessful,
            date: DateTime.parse(tx.createdAt).toLocal().toString(),
            memo: memoList[i],
          );
        }
      }
    } catch (e) {
      logger.e('Failed to get transactions: $e');
      throw Exception('Failed to get transactions');
    }
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

  Asset _getAsset(String assetCode) {
    if (assetCode == 'XLM') {
      return AssetTypeNative();
    }

    final asset = _currencies.currencies[assetCode];
    if (asset == null) {
      throw Exception('Asset $assetCode is not available');
    }

    return AssetTypeCreditAlphaNum4(asset.assetCode, asset.issuer);
  }

  /// Creates a DEX order by submitting a `ManageBuyOfferOperation` transaction.
  ///
  /// This function allows user to create an order to buy a specified asset
  /// using another asset on Stellar network.
  ///
  /// **Note:** Creating an order requires having XLM in the account
  /// to cover transaction fees and reserve requirements.
  ///
  /// **Price Format:**
  /// - The `price` should always include a leading zero for decimal values.
  /// - For example, instead of writing `.1`, the price should be written as `0.1`.
  ///   - **Correct format**: `0.1`
  ///   - **Incorrect format**: `.1`
  Future<bool> createOrder({
    required String sellingAssetCode,
    required String buyingAssetCode,
    required String amount,
    required String price,
    String? memo,
  }) async {
    if (!_currencies.currencies.containsKey(sellingAssetCode)) {
      throw Exception('Sell asset $sellingAssetCode is not available.');
    }
    if (!_currencies.currencies.containsKey(buyingAssetCode)) {
      throw Exception('Buy asset $buyingAssetCode is not available.');
    }

    final Asset sellingAsset = _getAsset(sellingAssetCode);
    final Asset buyingAsset = _getAsset(buyingAssetCode);

    final ManageSellOfferOperation sellOfferOperation =
        ManageSellOfferOperationBuilder(
                sellingAsset, buyingAsset, amount, price)
            .build();

    final account = await _sdk.accounts.account(accountId);
    final balances = account.balances;

    try {
      Balance? sellAssetBalance;
      Balance? buyAssetBalance;

      for (final balance in balances) {
        if (sellAssetBalance == null) {
          if (sellingAssetCode == 'XLM' && balance.assetCode == null) {
            sellAssetBalance = balance;
          } else if (balance.assetCode == sellingAssetCode) {
            sellAssetBalance = balance;
          }
        }

        if (buyingAssetCode != 'XLM' && buyAssetBalance == null) {
          if (balance.assetCode == buyingAssetCode) {
            buyAssetBalance = balance;
          }
        }

        if (sellAssetBalance != null &&
            (buyingAssetCode == 'XLM' || buyAssetBalance != null)) {
          break;
        }
      }

      if (sellAssetBalance == null) {
        logger.e("Sell asset $sellingAssetCode not found in balances.");
        throw Exception('Insufficient balance in $sellingAssetCode');
      }

      if (buyingAssetCode != 'XLM' && buyAssetBalance == null) {
        logger.e("Buy asset $buyingAssetCode not found in balances.");
        throw Exception('No trustline for $buyingAssetCode');
      }

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
        .addOperation(sellOfferOperation)
        .addMemo(memo != null ? Memo.text(memo) : Memo.none())
        .build();

    transaction.sign(_keyPair, _stellarNetwork);
    try {
      final SubmitTransactionResponse response =
          await _sdk.submitTransaction(transaction);
      if (!response.success) {
        if (response.extras?.resultCodes?.operationsResultCodes
                ?.contains('op_low_reserve') ==
            true) {
          throw Exception('Transaction failed due to low reserve.');
        }
        logger.e('Transaction failed with result: ${response.resultXdr}');
        return false;
      }

      return true;
    } catch (error) {
      throw Exception('Transaction failed due to: ${error.toString()}');
    }
  }

  /// Cancels a DEX order by submitting a `ManageBuyOfferOperation` transaction with zero amount.
  ///
  /// This function allows user to cancel previously created order with its offerId.
  ///
  /// **Note:** Cancelling an order requires having XLM in the account
  /// to cover transaction fees and reserve requirements.
  Future<bool> cancelOrder({required String offerId}) async {
    final offers = (await _sdk.offers.forAccount(accountId).execute()).records;
    final OfferResponse targetOffer = offers.firstWhere(
      (offer) => offer.id == offerId,
      orElse: () => throw Exception(
          'Offer with ID $offerId not found in user\'s account.'),
    );

    final Asset sellingAsset = targetOffer.selling;
    final Asset buyingAsset = targetOffer.buying;

    final ManageBuyOfferOperation cancelOfferOperation =
        ManageBuyOfferOperationBuilder(sellingAsset, buyingAsset, '0', '1')
            .setOfferId(offerId)
            .build();

    final account = await _sdk.accounts.account(accountId);
    final Transaction transaction =
        TransactionBuilder(account).addOperation(cancelOfferOperation).build();
    transaction.sign(_keyPair, _stellarNetwork);
    try {
      final SubmitTransactionResponse response =
          await _sdk.submitTransaction(transaction);
      if (!response.success) {
        if (response.extras?.resultCodes?.operationsResultCodes
                ?.contains('op_low_reserve') ==
            true) {
          throw Exception('Transaction failed due to low reserve.');
        }
        logger.e('Transaction failed with result: ${response.resultXdr}');
        return false;
      }
      return true;
    } catch (error) {
      throw Exception('Transaction failed due to: ${error.toString()}');
    }
  }

  /// Updating a DEX order by submitting a `ManageSellOfferOperation` transaction.
  ///
  /// This function allows user to update previously created order by its offerId.
  ///
  /// **Note:** Updating an order requires having XLM in the account
  /// to cover transaction fees and reserve requirements.
  ///
  /// **Price Format:**
  /// - The `price` should always include a leading zero for decimal values.
  /// - For example, instead of writing `.1`, the price should be written as `0.1`.
  ///   - **Correct format**: `0.1`
  ///   - **Incorrect format**: `.1`
  Future<bool> updateOrder(
      {required String amount,
      required String price,
      required String offerId,
      String? memo}) async {
    final offers = (await _sdk.offers.forAccount(accountId).execute()).records;
    final OfferResponse? targetOffer = offers.firstWhere(
      (offer) => offer.id == offerId,
      orElse: () => throw Exception(
          'Offer with ID $offerId not found in user\'s account.'),
    );

    ManageSellOfferOperation updateOfferOperation =
        ManageSellOfferOperationBuilder(
      targetOffer!.selling,
      targetOffer.buying,
      amount,
      price,
    ).setOfferId(offerId).build();

    final account = await _sdk.accounts.account(accountId);
    final Transaction transaction =
        TransactionBuilder(account).addOperation(updateOfferOperation).build();
    transaction.sign(_keyPair, _stellarNetwork);
    try {
      final SubmitTransactionResponse response =
          await _sdk.submitTransaction(transaction);
      if (!response.success) {
        if (response.extras?.resultCodes?.operationsResultCodes
                ?.contains('op_low_reserve') ==
            true) {
          throw Exception('Transaction failed due to low reserve.');
        }
        logger.e('Transaction failed with result: ${response.resultXdr}');
        return false;
      }
      return true;
    } catch (error) {
      throw Exception('Transaction failed due to: ${error.toString()}');
    }
  }

  /// Lists all active offers created by the current account.
  ///
  /// This function fetches a list of `OfferResponse` objects representing
  /// open orders created by the account.
  ///
  /// ### Understanding Stellar Order Representation:
  /// - **Price (`OfferResponse.price`)**: Stellar stores price as `buying / selling`,
  ///   meaning the displayed price is the **inverse** of the price provided
  ///   when creating an order.
  /// - **Amount (`OfferResponse.amount`)**: This represents the amount of the
  ///   **buying asset** still available for trade, not the original amount
  ///   of the selling asset.
  ///
  /// ### Conversion Formula:
  /// When placing an order:
  /// ```
  /// Total selling amount = Buying amount * Price
  /// ```
  ///
  /// Stellar inverts the price when storing the offer:
  /// ```
  /// Stored price = 1 / Provided price
  /// ```
  ///
  /// ### Example:
  /// #### **Creating an Order**
  /// ```dart
  /// await stellarClient.createOrder(
  ///     sellingAssetCode: 'USDC',
  ///     buyingAssetCode: 'TFT',
  ///     amount: '5',     // Buying 5 TFT
  ///     price: '0.02');  // 1 USDC = 0.02 TFT
  /// ```
  ///
  /// #### **Retrieved Offer (from Stellar Order Book)**
  /// ```dart
  /// OfferResponse {
  ///   amount: "0.2",    // Total selling amount = 5 * 0.02 = 0.2 USDC
  ///   price: "50.0"     // Inverted: 1 / 0.02 = 50 USDC per TFT
  /// }
  /// ```
  ///
  /// **Key Takeaways:**
  /// - `OfferResponse.amount` = **Total amount of the selling asset left**.
  /// - `OfferResponse.price` = **Inverse of the provided price**.
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
