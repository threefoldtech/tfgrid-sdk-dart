# Gridproxy Client

This is a dart client to communicate with GridProxy based on the network.

## Install Dependencies

``` bash
dart pub get
```

## Usage

```dart
 GridProxyClient client = GridProxyClient('gridproxy.dev.grid.tf');
 final options = ListFarmsQueryParameters(farmId: 1);
 final farms = await client.farms.listFarms(options);
 print(farms);
```
