# tfchain_client

This a Dart client to communicate with TFChain.

```bash
dart pub get
```

## Usage

There are 2 types of client. one for just query the chain and the other one for query and do transaction on the chain.

### Query Client

```dart
import 'package:tfchain_client/tfchain_client.dart';

final client = QueryClient("wss://tfchain.dev.grid.tf/ws");
await client.connect();
final contract = await client.contracts.get(contractId: BigInt.from(123456));
print(contract!.toJson());
await client.disconnect();
```

### Full Client

```dart
final client = Client("wss://tfchain.dev.grid.tf/ws", "your-mnemonic", "sr25519");
client.connect();
final farmId = await client.farms.create(CreateFarmOptions(name: "name"));
print(farmId);
await client.disconnect();
```

## Generating Functions

To generate functions for the chain, add the following configuration in `pubspec.yaml`:

```bash
polkadart:
  output_dir: lib/generated
  chains:
    dev: chain-url
```

Then run the following command:

```bash
dart run polkadart_cli:generate -v
```

## Run Tests
### Prerequisites

1- Provide your mnemonic as environment variable.
```bash
export MNEMONIC="your-mnemonic"
```
2- provide chain url and the signing type.
By default the chain url is set to `wss://tfchain.dev.grid.tf/ws` and the signing type is `sr25519`. Note that signing type can be either `sr25519` or `ed25519`.

```bash
export URL="chain_url"
```
```bash
export KEYPAIR_TYPE="sr25519"
```
To run the tests, run the following command

```bash
dart test
```
