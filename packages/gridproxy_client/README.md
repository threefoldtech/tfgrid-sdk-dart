# Gridproxy Client

This is a dart client to communicate with GridProxy based on the network.

## Install Dependencies

``` bash
dart pub get
```

## Generate Reflectable code

```bash
dart run build_runner build
```

## Usage

- Ensure that initializeReflectable() is called at the beginning of your main

- Example usage:

```dart
 import 'graphql_client.reflectable.dart';

 initializeReflectable();

 GridProxyClient client = GridProxyClient('gridproxy.dev.grid.tf');
  final queryOptions =
      FarmsQueryOptions(limit: 10, orderBy: FarmsOrderByOptions.farmID_DESC);
  final returnOptions = FarmsReturnOptions(
    id: true,
    farmID: true,
    name: true,
    twinID: true,
    publicIps: PublicIpsReturnOptions(ip: true, contractId: true, id: true, gateway: true));
 final farms =
      await graphQLClient.farms.listFarms(queryOptions, returnOptions);
```