# tfgrid-sdk-dart

[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos) [![codecov](https://codecov.io/gh/threefoldtech/tfgrid-sdk-dart/graph/badge.svg?token=KrlhzzdP72)](https://codecov.io/gh/threefoldtech/tfgrid-sdk-dart)

Dart client libraries for interacting with the ThreeFold Grid. This SDK enables Flutter and Dart applications to deploy workloads, manage identities, query grid resources, and interact with the underlying blockchain and proxy services through idiomatic Dart APIs.

## What this is

This repository provides a set of Dart packages that abstract the grid's RPC, blockchain, GraphQL, and payment interfaces into typed, easy-to-use Dart APIs. It is designed for mobile and desktop developers who want to build applications that interact with grid infrastructure from a Dart or Flutter codebase.

## What this repository contains

- [signer](./packages/signer/README.md) — Cryptographic signing utilities for grid identities and transactions.
- [tfchain_client](./packages/tfchain_client/README.md) — Client for interacting with the TFChain substrate blockchain.
- [gridproxy_client](./packages/gridproxy_client/README.md) — Client for the grid proxy API, used to query nodes, contracts, and statistics.
- [graphql_client](./packages/graphql_client/README.md) — Client for the grid GraphQL API.
- [stellar_client](./packages/stellar_client/README.md) — Client for Stellar-based payment operations.

## Role in the stack

The SDK sits at the application layer, providing Dart and Flutter apps with a typed interface to the lower-level grid services. It communicates with TFChain for on-chain operations, the grid proxy for resource discovery, GraphQL for data queries, and Stellar for payments. It is typically used alongside other grid SDKs and tooling when building cross-platform user interfaces or mobile automation.

## Relation to ThreeFold

This technology is used within the ThreeFold ecosystem and was first deployed on the ThreeFold Grid. The component itself is designed as reusable infrastructure technology and should be understood by its technical function first, independent of any specific deployment.

## Ownership

This repository is owned and maintained by TF-Tech NV, a Belgian company responsible for the development and maintenance of this technology.

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
```

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
Copyright (c) TF-Tech NV.
