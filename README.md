# tfgrid-sdk-dart

[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos) [![codecov](https://codecov.io/gh/threefoldtech/tfgrid-sdk-dart/graph/badge.svg?token=KrlhzzdP72)](https://codecov.io/gh/threefoldtech/tfgrid-sdk-dart)

This repository contains the Dart SDK clients for interacting with the ThreeFold Grid, including TFChain, grid proxy, GraphQL, and Stellar clients.

## Packages

- [signer](./packages/signer/README.md)
- [tfchain_client](./packages/tfchain_client/README.md)
- [gridproxy_client](./packages/gridproxy_client/README.md)
- [graphql_client](./packages/graphql_client/README.md)
- [stellar_client](./packages/stellar_client/README.md)

## Prerequisites

Make sure you have the following tools installed:

- [Dart SDK](https://dart.dev/get-dart)
- [Melos](https://pub.dev/packages/melos)
- [Coverde](https://pub.dev/packages/coverde)


## Initialize Workspace

To initialize workspace in all packages run the following command

```bash
melos bootstrap
```

## Code Analysis

To analyze code in all dart package run the following command

```bash
melos run analyze
```

## Run Unit Tests

To run unit tests in all packages that have `test` directory, run the following command

```bash
docker run --network host ghcr.io/threefoldtech/tfchain --dev --rpc-cors all --rpc-external --rpc-methods=safe
```

Then run :

```bash
melos run unit_test
```

## Generate Coverage

To generate coverage for all packages and merge the results, use the following commands

```bash
melos run unit_test_and_coverage
```

Check results from `result.txt` with the following command

```bash
cat coverage/result.txt

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
Copyright (c) TFTech NV.
```
