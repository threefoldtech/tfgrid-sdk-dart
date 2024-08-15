part of '../stellar_client.dart';

class Client {
  final NetworkType network;
  late StellarSDK sdk;
  late KeyPair keyPair;
  late currency.Currencies currencies;
  late Map<String, String> serviceUrls;

  Client(this.network) {
    late final currency.Currency tft;
    serviceUrls = {
      'PUBLIC': 'https://tokenservices.threefold.io/threefoldfoundation',
      'TESTNET': 'https://testnet.threefold.io/threefoldfoundation'
    };
    switch (network) {
      case NetworkType.TESTNET:
        sdk = StellarSDK.TESTNET;
        tft = currency.Currency(
          assetCode: 'TFT',
          issuer: "GA47YZA3PKFUZMPLQ3B5F2E3CJIB57TGGU7SPCQT2WAEYKN766PWIMB3",
        );
        break;
      case NetworkType.PUBLIC:
        sdk = StellarSDK.PUBLIC;
        tft = currency.Currency(
          assetCode: 'TFT',
          issuer: "GBOVQKJYHXRR3DX6NOX2RRYFRCUMSADGDESTDNBDS6CDVLGVESRTAC47",
        );
        break;
      default:
        break;
    }

    currencies = currency.Currencies({'TFT': tft});
  }

  Future<AccountResponse?> loadAccountFromPublicKey(
      {required String accountId}) async {
    try {
      final account = await sdk.accounts.account(accountId);
      keyPair = account.keypair;
      return account;
    } catch (error) {
      print("Error Loading Account $error");
      return null;
    }
  }

  Future<KeyPair> loadAccountFromSecretSeed(
      {required String secretSeed}) async {
    keyPair = KeyPair.fromSecretSeed(secretSeed);
    return keyPair;
  }

  Future<KeyPair?> createThreefoldAccount({required String mnemonic}) async {
    try {
      if (mnemonic.isNotEmpty) {
        Wallet wallet = await Wallet.from(mnemonic);
        keyPair = await wallet.getKeyPair();
      } else {
        keyPair = KeyPair.random();
      }

      Network networkType;
      if (network == NetworkType.TESTNET) {
        networkType = Network.TESTNET;
      } else if (network == NetworkType.PUBLIC) {
        networkType = Network.PUBLIC;
      } else {
        throw Exception("Unsupported network type");
      }

      Transaction? transaction = await getActivationTransaction();
      if (transaction != null) {
        transaction.sign(keyPair, networkType);
        await sdk.submitTransaction(transaction);
        print("Account Activated Successfully.");
      } else {
        throw Exception("Failed to retrieve activation transaction.");
      }

      await sdk.accounts.account(keyPair.accountId);

      return keyPair;
    } catch (error) {
      throw Exception("Failed to create account $error");
    }
  }

  Future<KeyPair?> createAccountFromSecret({required String secretSeed}) async {
    try {
      KeyPair existingAccountPair = KeyPair.fromSecretSeed(secretSeed);
      keyPair = KeyPair.random();
      AccountResponse existingAccount =
          await sdk.accounts.account(existingAccountPair.accountId);

      Transaction transaction = TransactionBuilder(existingAccount)
          .addOperation(
              CreateAccountOperationBuilder(keyPair.accountId, "10").build())
          .build();

      if (network == NetworkType.TESTNET) {
        transaction.sign(existingAccountPair, Network.TESTNET);
      } else if (network == NetworkType.PUBLIC) {
        transaction.sign(existingAccountPair, Network.PUBLIC);
      }

      await sdk.submitTransaction(transaction);
      await sdk.accounts.account(keyPair.accountId);
      return keyPair;
    } catch (error) {
      print("Failed to create account $error");
    }
    return null;
  }

  // If testnet account activated with FriendBot, the asset should be added manually.
  Future<bool> activateTestNetAccount({required String accountId}) async {
    try {
      bool funded = await FriendBot.fundTestAccount(accountId);
      if (funded) {
        print("Account funded successfully");
      } else {
        print("Failed to fund account");
      }
      return funded;
    } catch (error) {
      print("Error while funding account: $error");
      return false;
    }
  }

  Future<void> addTrustLine(KeyPair pair) async {
    for (var entry in currencies.currencies.entries) {
      String currencyCode = entry.key;
      currency.Currency Currency = entry.value;

      String issuerAccountId = Currency.issuer;
      Asset currencyAsset =
          AssetTypeCreditAlphaNum4(Currency.assetCode, issuerAccountId);

      // TODO:
      ChangeTrustOperationBuilder changeTrustOperation =
          ChangeTrustOperationBuilder(currencyAsset, "300000");

      final account = await loadAccountFromPublicKey(accountId: pair.accountId);

      Transaction transaction = new TransactionBuilder(account!)
          .addOperation(changeTrustOperation.build())
          .build();

      if (network == NetworkType.TESTNET) {
        transaction.sign(pair, Network.TESTNET);
      } else if (network == NetworkType.PUBLIC) {
        transaction.sign(pair, Network.PUBLIC);
      }

      SubmitTransactionResponse response =
          await sdk.submitTransaction(transaction);

      if (!response.success) {
        print("Failed to add trustline for $currencyCode");
      } else {
        print("trustline for $currencyCode was added successfully");
      }
    }
  }

  Future<void> sendTransaction(
      {required KeyPair sourceKeyPair,
      required String destinationAddress,
      required String amount,
      required String currency,
      String? memoText}) async {
    try {
      // check that receiver account exists
      final receiver =
          await loadAccountFromPublicKey(accountId: destinationAddress);
      if (receiver == null) {
        throw Exception('Receiver account does not exist.');
      }

      // check that asset exists
      var specificBalance = receiver.balances.firstWhere(
        (balance) => balance.assetCode == currency,
        orElse: () {
          throw Exception('Balance with asset code $currency not found.');
        },
      );

      final asset = currencies.currencies[currency];
      if (asset == null) {
        throw Exception('$currency not supported');
      }

      AccountResponse sender =
          await sdk.accounts.account(sourceKeyPair.accountId);

      Asset tftAsset = AssetTypeCreditAlphaNum4(asset.assetCode, asset.issuer);

      Transaction transaction = TransactionBuilder(sender)
          .addOperation(
              PaymentOperationBuilder(destinationAddress, tftAsset, amount)
                  .build())
          .addMemo(memoText != null ? Memo.text(memoText) : Memo.none())
          .build();

      transaction.sign(sourceKeyPair, Network.TESTNET);
      await sdk.submitTransaction(transaction);
      print("Transaction successful.");
    } catch (error) {
      print("Failed to send transaction: $error");
    }
  }

  Future<Transaction?> getActivationTransaction() async {
    try {
      final response = await http.post(
        Uri.parse(
            '${serviceUrls[network.toString()]}/activation_service/activate_account'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'address': keyPair.accountId}),
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

  // take asset code code && issuer (optional)
  Future<void> fundTrustLine(String asset_code) async {
    final asset = currencies.currencies[asset_code];
    if (asset == null) {
      throw Exception("Asset $asset_code not supported");
    }

    try {
      final response = await http.post(
        Uri.parse(
            '${serviceUrls[network.toString()]}/activation_service/fund_trustline'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'asset': '${asset.assetCode}:${asset.issuer}',
          'address': keyPair.accountId
        }),
      );

      final data = jsonDecode(response.body);

      String trustlineTransaction = data['addtrustline_transaction'];
      XdrTransactionEnvelope xdrTxEnvelope =
          XdrTransactionEnvelope.fromEnvelopeXdrString(trustlineTransaction);

      Transaction transaction =
          Transaction.fromV1EnvelopeXdr(xdrTxEnvelope.v1!);
      if (network.toString() == 'TESTNET') {
        transaction.sign(keyPair, Network.TESTNET);
      } else if (network.toString() == 'PUBLIC') {
        transaction.sign(keyPair, Network.PUBLIC);
      }

      SubmitTransactionResponse response2 =
          await sdk.submitTransaction(transaction);

      if (response2.success) {
        print("Trustline for $asset_code added successfully.");
      } else {
        print("Failed to add trustline for $asset_code.");
      }
    } catch (error) {
      print("Error funding trustline : $error");
    }
  }

  Future<TransactionData?> fetchFundDetails({required String assetCode}) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${serviceUrls[network.toString()]}/transactionfunding_service/conditions'),
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
        print(transactionData);
        return transactionData;
      } else {
        print('Failed to details for asset: ');
      }

      return null;
    } catch (error) {
      print("Failed to get fund details, $error");
      throw Exception(error);
    }
  }

  Future<Operation?> makeFundPaumentOperation(
      {required String assetCode, required String issuer}) async {
    TransactionData? transactionData =
        await fetchFundDetails(assetCode: assetCode);
    Asset asset = AssetTypeCreditAlphaNum4(assetCode, issuer);

    return PaymentOperationBuilder(
            transactionData!.feeAccountId, asset, transactionData.feeFixed)
        .build();
  }

  Future<Transaction?> buildFundedPaymentTransaction(
      {required KeyPair sourceKeyPair,
      required String destinationAddress,
      required String amount,
      required String currency,
      String? memoText}) async {
    // check that receiver account exists
    final receiver =
        await loadAccountFromPublicKey(accountId: destinationAddress);

    // check that asset exists
    var specificBalance = receiver!.balances.firstWhere(
      (balance) => balance.assetCode == currency,
      orElse: () {
        throw Exception('Balance with asset code ${currency} not found.');
      },
    );

    final asset = currencies.currencies[currency];
    if (asset == null) {
      throw Exception('${currency} not supported');
    }

    AccountResponse sourceAccount =
        await sdk.accounts.account(keyPair.accountId);

    Operation? paymentOperation = await makeFundPaumentOperation(
        assetCode: asset.assetCode, issuer: asset.issuer);

    Asset tftAsset = AssetTypeCreditAlphaNum4(asset.assetCode, asset.issuer);

    Transaction transaction = TransactionBuilder(sourceAccount)
        .addOperation(paymentOperation!)
        .addOperation(
            PaymentOperationBuilder(destinationAddress, tftAsset, amount)
                .build())
        .addMemo(memoText != null ? Memo.text(memoText!) : Memo.none())
        .build();
    return transaction;
  }

  Future<void> submitFundedTransaction(Transaction fundedTransaction) async {
    if (network == NetworkType.TESTNET) {
      fundedTransaction.sign(keyPair, Network.TESTNET);
    } else if (network == NetworkType.PUBLIC) {
      fundedTransaction.sign(keyPair, Network.PUBLIC);
    }

    print('Sending to');
    print(
        '${serviceUrls[network.toString()]}/transactionfunding_service/fund_transaction');

    try {
      final response = await http.post(
        Uri.parse(
            '${serviceUrls[network.toString()]}/transactionfunding_service/fund_transaction'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'transaction': fundedTransaction.toXdr()}),
      );

      print(response.body);
    } catch (error) {
      throw Exception('Something went wrong! $error');
    }
  }

  Future<void> getTransactions() async {
    Page<OperationResponse> payments = await sdk.payments
        .forAccount(keyPair.accountId)
        .order(RequestBuilderOrder.DESC)
        .execute();

    if (payments.records != null && payments.records!.isNotEmpty) {
      for (OperationResponse response in payments.records!) {
        print("Operation type: ${response.runtimeType}");
        print("Transaction hash: ${response.transactionHash}");

        if (response is PaymentOperationResponse) {
          _handlePaymentOperationResponse(response);
        } else if (response is CreateAccountOperationResponse) {
          _handleCreateAccountOperationResponse(response);
        } else if (response is PathPaymentStrictReceiveOperationResponse) {
          _handlePathPaymentStrictReceiveOperationResponse(response);
        } else {
          print("Unhandled operation type: ${response.runtimeType}");
        }
      }
    } else {
      print("No payment records found.");
    }
  }

  void _handlePathPaymentStrictReceiveOperationResponse(
      PathPaymentStrictReceiveOperationResponse response) {
    print("\n--- Path Payment Strict Receive Operation ---");

    print("From: ${response.from}");
    print("To: ${response.to}");

    print("Source Amount: ${response.sourceAmount}");
    print("Source Asset Code: ${response.sourceAssetCode ?? 'XLM'}");

    print("Destination Amount: ${response.amount}");
    print("Destination Asset Code: ${response.assetCode} ");

    print("--------------------------------------------\n");
  }

  void _handlePaymentOperationResponse(PaymentOperationResponse response) {
    print("\n--- Payment Operation ---");
    if (response.transactionSuccessful!) {
      print("Transaction was successful.");
      bool isSender = response.from!.accountId == keyPair.accountId;

      if (isSender) {
        print("Role: Sender");
        print("Sent to: ${response.to!.accountId}");
      } else {
        print("Role: Receiver");
        print("Received from: ${response.from!.accountId}");
      }

      print("Amount: ${response.amount}");
      print("Asset Code: ${response.assetCode ?? 'XLM'}");
    } else {
      print("Transaction was not successful.");
    }
    print("--------------------------------\n");
  }

  void _handleCreateAccountOperationResponse(
      CreateAccountOperationResponse response) {
    print("\n--- Create Account Operation ---");
    print("Account created: ${response.account}");
    // Which asset is the starting balance ??
    print("Starting balance: ${response.startingBalance!}");
    print("-----------------------------------\n");
  }

  Future<List<Map<String, dynamic>>> getBalance() async {
    List<Map<String, dynamic>> balancesList = [];
    AccountResponse account = await sdk.accounts.account(keyPair.accountId);
    for (Balance balance in account.balances) {
      Map<String, dynamic> balanceMap = {};
      switch (balance.assetType) {
        case Asset.TYPE_NATIVE:
          balanceMap['assetCode'] = 'XLM';
          balanceMap['balance'] = balance.balance;
          break;
        default:
          balanceMap['assetCode'] = balance.assetCode;
          balanceMap['balance'] = balance.balance;
      }
      balancesList.add(balanceMap);
    }
    return balancesList;
  }
}
