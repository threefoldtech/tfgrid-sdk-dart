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

- If no mnemonic is provided, the client will create a new one using `Client.create`. If a mnemonic is provided, the client will be created using `Client.createFromMnemonic`.
- Account can be activated through friendbot (only for testnet).
- After activation, trustlines can be added to the account.

```dart
  import 'package:stellar_client/stellar_client.dart';

  final stellarClient = Client.create(NetworkType.TESTNET);
  // final stellarClient = await Client.createFromMnemonic(NetworkType.TESTNET, "mnemonic");

  await stellarClient.activateThroughFriendBot(accountId: stellarClient.accountId);
  await stellarClient.addTrustLine();

  final balance = await stellarClient.getBalance();
  print(balance);
```

Load previously created account:

- Accounts can be loaded from secret seed.

```dart
  import 'package:stellar_client/stellar_client.dart';

  final stellarClient = Client(NetworkType.TESTNET, secretSeed);
  final transactions = await stellarClient.getTransactions();
  print(transactions);
```  

### PUBLIC

- Activation through Threefold service will add assets automatically.

```dart
  import 'package:stellar_client/stellar_client.dart';

  final stellarClient = Client.create(NetworkType.PUBLIC);
  await stellarClient.activateThroughThreefoldService();

  await stellarClient.transfer(
      destinationAddress: "destination-public-key",
      amount: "20",
      currency: "TFT",
      memoText: "Memo Text");

  await stellarClient.getTransactions();
```
