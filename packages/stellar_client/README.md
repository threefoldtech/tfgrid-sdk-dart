# Stellar Client

This Dart client allows you to communicate with the Stellar network, enabling the creation or loading of existing Stellar accounts. It supports interactions with both the testnet and public network, and the assets currently supported are TFT (Threefold Token) and XLM (Stellar Lumens).

## Installation

To install the necessary dependencies, run:

```bash
dart pub get
```

## Usage

This client enables you to create new Stellar accounts or load existing ones on the testnet or public network. Once an account is created or loaded, you can manage assets such as TFT and XLM.

### TESTNET

Create new testnet account:

- If no mnemonic provided, it will be created by the client.
- By default the account activated by threefold activation service, will contains both assets TFT and XLM.

```dart
  import 'package:stellar_client/stellar_client.dart';

  final stellarClient = Client(NetworkType.TESTNET);
  final keypair = stellarClient.createThreefoldAccount(mnemonic: "");
  final balance = await stellarClient.getBalance();
  print(balance);

  await stellarClient.getTransactions();
```

Load previously created account:

- Accounts can be loaded from public key or secret seed.
- If user wants to make any transactions, account should be loaded from secret seed.

```dart
  import 'package:stellar_client/stellar_client.dart';

  final stellarClient = Client(NetworkType.TESTNET);
  final account = stellarClient.loadAccountFromPublicKey(accountId: "account_id");
```  

### PUBLIC

```dart
  import 'package:stellar_client/stellar_client.dart';

  final stellarClient = Client(NetworkType.PUBLIC);
  final keypair = stellarClient.createThreefoldAccount(mnemonic: "");
  await stellarClient.sendTransaction(
      sourceKeyPair: account,
      destinationAddress:
          "destination-public-key",
      amount: "20",
      currency: "TFT",
      memoText: "Memo Text");

  await stellarClient.getTransactions();
```