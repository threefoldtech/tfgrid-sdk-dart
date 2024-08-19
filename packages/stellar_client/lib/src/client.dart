part of '../stellar_client.dart';

class Client {
  final NetworkType _network;
  late StellarSDK _sdk;
  late KeyPair _keyPair;
  late currency.Currencies _currencies;
  late Map<String, String> _serviceUrls;

  String get accountId => _keyPair.accountId;
  String get secretSeed => _keyPair.secretSeed;

  Client(this._network, String secretSeed) {
    _keyPair = KeyPair.fromSecretSeed(secretSeed);
    _initialize();
  }

  factory Client.create(NetworkType network) {
    final keyPair = KeyPair.random();
    return Client(network, keyPair.secretSeed);
  }

  static Future<Client> createFromMnemonic(
      NetworkType network, String mnemonic) async {
    Wallet wallet = await Wallet.from(mnemonic);
    final keyPair = await wallet.getKeyPair();
    return Client(network, keyPair.secretSeed);
  }

  void _initialize() {
    late final currency.Currency tft;
    _serviceUrls = {
      'PUBLIC': 'https://tokenservices.threefold.io/threefoldfoundation',
      'TESTNET': 'https://testnet.threefold.io/threefoldfoundation'
    };
    switch (_network) {
      case NetworkType.TESTNET:
        _sdk = StellarSDK.TESTNET;
        tft = currency.Currency(
          assetCode: 'TFT',
          issuer: "GA47YZA3PKFUZMPLQ3B5F2E3CJIB57TGGU7SPCQT2WAEYKN766PWIMB3",
        );
        break;
      case NetworkType.PUBLIC:
        _sdk = StellarSDK.PUBLIC;
        tft = currency.Currency(
          assetCode: 'TFT',
          issuer: "GBOVQKJYHXRR3DX6NOX2RRYFRCUMSADGDESTDNBDS6CDVLGVESRTAC47",
        );
        break;
      default:
        throw Exception('Unsupported network type');
    }

    _currencies = currency.Currencies({'TFT': tft});
  }

  Future<bool> activateThroughThreefoldService() async {
    Network networkType;
    if (_network == NetworkType.TESTNET) {
      networkType = Network.TESTNET;
    } else if (_network == NetworkType.PUBLIC) {
      networkType = Network.PUBLIC;
    } else {
      throw Exception("Unsupported network type");
    }

    Transaction? transaction = await _getActivationTransaction();
    if (transaction != null) {
      transaction.sign(_keyPair, networkType);
      await _sdk.submitTransaction(transaction);
      print("Account Activated Successfully.");
      print("TFT Asset was added Successfully ");
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
    if (_network.toString() != Network.TESTNET.toString()) {
      throw Exception("Network should be TEST");
    }
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

  Future<bool> addTrustLine() async {
    for (var entry in _currencies.currencies.entries) {
      String currencyCode = entry.key;
      currency.Currency Currency = entry.value;

      String issuerAccountId = Currency.issuer;
      Asset currencyAsset =
          AssetTypeCreditAlphaNum4(Currency.assetCode, issuerAccountId);

      // TODO:
      ChangeTrustOperationBuilder changeTrustOperation =
          ChangeTrustOperationBuilder(currencyAsset, "300000");

      final account = await _sdk.accounts.account(accountId);

      Transaction transaction = TransactionBuilder(account)
          .addOperation(changeTrustOperation.build())
          .build();

      if (_network == NetworkType.TESTNET) {
        transaction.sign(_keyPair, Network.TESTNET);
      } else if (_network == NetworkType.PUBLIC) {
        transaction.sign(_keyPair, Network.PUBLIC);
      }

      SubmitTransactionResponse response =
          await _sdk.submitTransaction(transaction);

      if (!response.success) {
        print("Failed to add trustline for $currencyCode");
        return false;
      } else {
        print("trustline for $currencyCode was added successfully");
        return true;
      }
    }

    print("No trustlines were processed");
    return false;
  }

  Future<bool> sendTransaction(
      {required String destinationAddress,
      required String amount,
      required String currency,
      String? memoText}) async {
    try {
      final receiver = await _sdk.accounts.account(accountId);

      var specificBalance = receiver.balances.firstWhere(
        (balance) => balance.assetCode == currency,
        orElse: () {
          throw Exception('Balance with asset code $currency not found.');
        },
      );

      final asset = _currencies.currencies[currency];
      if (asset == null) {
        throw Exception('$currency not supported');
      }

      AccountResponse sender = await _sdk.accounts.account(accountId);

      Asset tftAsset = AssetTypeCreditAlphaNum4(asset.assetCode, asset.issuer);

      Transaction transaction = TransactionBuilder(sender)
          .addOperation(
              PaymentOperationBuilder(destinationAddress, tftAsset, amount)
                  .build())
          .addMemo(memoText != null ? Memo.text(memoText) : Memo.none())
          .build();

      transaction.sign(_keyPair, Network.TESTNET);
      await _sdk.submitTransaction(transaction);
      print("Transaction successful.");
      return true;
    } catch (error) {
      print("Failed to send transaction: $error");
      return false;
    }
  }

  // Future<KeyPair?> createAccountFromSecret({required String secretSeed}) async {
  //   try {
  //     KeyPair existingAccountPair = KeyPair.fromSecretSeed(secretSeed);
  //     keyPair = KeyPair.random();
  //     AccountResponse existingAccount =
  //         await sdk.accounts.account(existingAccountPair.accountId);

  //     Transaction transaction = TransactionBuilder(existingAccount)
  //         .addOperation(
  //             CreateAccountOperationBuilder(keyPair.accountId, "10").build())
  //         .build();

  //     if (network == NetworkType.TESTNET) {
  //       transaction.sign(existingAccountPair, Network.TESTNET);
  //     } else if (network == NetworkType.PUBLIC) {
  //       transaction.sign(existingAccountPair, Network.PUBLIC);
  //     }

  //     await sdk.submitTransaction(transaction);
  //     await sdk.accounts.account(keyPair.accountId);
  //     return keyPair;
  //   } catch (error) {
  //     print("Failed to create account $error");
  //   }
  //   return null;
  // }

  // take asset code code && issuer (optional)
  Future<bool> fundTrustLine(String asset_code) async {
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
      if (_network.toString() == 'TESTNET') {
        transaction.sign(_keyPair, Network.TESTNET);
      } else if (_network.toString() == 'PUBLIC') {
        transaction.sign(_keyPair, Network.PUBLIC);
      }

      SubmitTransactionResponse response2 =
          await _sdk.submitTransaction(transaction);

      if (response2.success) {
        print("Trustline for $asset_code added successfully.");
        return true;
      } else {
        print("Failed to add trustline for $asset_code.");
        return false;
      }
    } catch (error) {
      throw Exception("Error funding trustline : $error");
    }
  }

  Future<TransactionData?> fetchFundDetails({required String assetCode}) async {
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
        print(transactionData);
        return transactionData;
      } else {
        print('Failed to details for asset: ');
      }

      return null;
    } catch (error) {
      throw Exception("Failed to get fund details, $error");
    }
  }

  // Future<Operation?> makeFundPaumentOperation(
  //     {required String assetCode, required String issuer}) async {
  //   TransactionData? transactionData =
  //       await fetchFundDetails(assetCode: assetCode);
  //   Asset asset = AssetTypeCreditAlphaNum4(assetCode, issuer);

  //   return PaymentOperationBuilder(
  //           transactionData!.feeAccountId, asset, transactionData.feeFixed)
  //       .build();
  // }

  // Future<Transaction?> buildFundedPaymentTransaction(
  //     {required KeyPair sourceKeyPair,
  //     required String destinationAddress,
  //     required String amount,
  //     required String currency,
  //     String? memoText}) async {
  //   // check that receiver account exists
  //   final receiver =
  //       await loadAccountFromPublicKey(accountId: destinationAddress);

  //   // check that asset exists
  //   var specificBalance = receiver!.balances.firstWhere(
  //     (balance) => balance.assetCode == currency,
  //     orElse: () {
  //       throw Exception('Balance with asset code ${currency} not found.');
  //     },
  //   );

  //   final asset = currencies.currencies[currency];
  //   if (asset == null) {
  //     throw Exception('${currency} not supported');
  //   }

  //   AccountResponse sourceAccount =
  //       await sdk.accounts.account(keyPair.accountId);

  //   Operation? paymentOperation = await makeFundPaumentOperation(
  //       assetCode: asset.assetCode, issuer: asset.issuer);

  //   Asset tftAsset = AssetTypeCreditAlphaNum4(asset.assetCode, asset.issuer);

  //   Transaction transaction = TransactionBuilder(sourceAccount)
  //       .addOperation(paymentOperation!)
  //       .addOperation(
  //           PaymentOperationBuilder(destinationAddress, tftAsset, amount)
  //               .build())
  //       .addMemo(memoText != null ? Memo.text(memoText!) : Memo.none())
  //       .build();
  //   return transaction;
  // }

  // Future<void> submitFundedTransaction(Transaction fundedTransaction) async {
  //   if (network == NetworkType.TESTNET) {
  //     fundedTransaction.sign(keyPair, Network.TESTNET);
  //   } else if (network == NetworkType.PUBLIC) {
  //     fundedTransaction.sign(keyPair, Network.PUBLIC);
  //   }

  //   print('Sending to');
  //   print(
  //       '${serviceUrls[network.toString()]}/transactionfunding_service/fund_transaction');

  //   try {
  //     final response = await http.post(
  //       Uri.parse(
  //           '${serviceUrls[network.toString()]}/transactionfunding_service/fund_transaction'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'transaction': fundedTransaction.toXdr()}),
  //     );

  //     print(response.body);
  //   } catch (error) {
  //     throw Exception('Something went wrong! $error');
  //   }
  // }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    Page<OperationResponse> payments = await _sdk.payments
        .forAccount(accountId)
        .order(RequestBuilderOrder.DESC)
        .execute();
    List<Map<String, dynamic>> transactionDetails = [];

    if (payments.records != null && payments.records!.isNotEmpty) {
      for (OperationResponse response in payments.records!) {
        if (response is PaymentOperationResponse) {
          var details = _handlePaymentOperationResponse(response);
          transactionDetails.add({'type': 'Payment', 'details': details});
        } else if (response is CreateAccountOperationResponse) {
          var details = _handleCreateAccountOperationResponse(response);
          transactionDetails.add({'type': 'CreateAccount', 'details': details});
        } else if (response is PathPaymentStrictReceiveOperationResponse) {
          var details =
              _handlePathPaymentStrictReceiveOperationResponse(response);
          transactionDetails
              .add({'type': 'PathPaymentStrictReceive', 'details': details});
        } else {
          print("Unhandled operation type: ${response.runtimeType}");
        }
      }
    } else {
      print("No payment records found.");
    }

    return transactionDetails;
  }

  PathPaymentStrictReceiveOperationDetails
      _handlePathPaymentStrictReceiveOperationResponse(
          PathPaymentStrictReceiveOperationResponse response) {
    return PathPaymentStrictReceiveOperationDetails(
      from: response.from!,
      to: response.to!,
      sourceAmount: double.parse(response.sourceAmount!),
      sourceAssetCode: response.sourceAssetCode ?? 'XLM',
      destinationAmount: double.parse(response.amount!),
      destinationAssetCode: response.assetCode!,
    );
  }

  PaymentOperationDetails _handlePaymentOperationResponse(
      PaymentOperationResponse response) {
    return PaymentOperationDetails(
      from: response.from!.accountId,
      to: response.to!.accountId,
      amount: double.parse(response.amount!),
      assetCode: response.assetCode ?? 'XLM',
      isSuccessful: response.transactionSuccessful!,
    );
  }

  CreateAccountOperationDetails _handleCreateAccountOperationResponse(
      CreateAccountOperationResponse response) {
    return CreateAccountOperationDetails(
      account: response.account!,
      startingBalance: double.parse(response.startingBalance!),
    );
  }

  Future<List<Map<String, dynamic>>> getBalance() async {
    List<Map<String, dynamic>> balancesList = [];
    AccountResponse account = await _sdk.accounts.account(accountId);
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
