import 'dart:io';

import 'package:polkadart/polkadart.dart';
import 'package:test/test.dart';
import 'package:tfchain_client/src/balances.dart';
import 'package:tfchain_client/src/contracts.dart';
import 'package:tfchain_client/src/dao.dart';
import 'package:tfchain_client/src/farms.dart';
import 'package:tfchain_client/src/nodes.dart';
import 'package:tfchain_client/src/pricing_policies.dart';
import 'package:tfchain_client/src/tft_bridge.dart';
import 'package:tfchain_client/src/tft_price.dart';
import 'package:tfchain_client/src/twins.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group('Query Client Tests', () {
    late QueryClient queryClient;
    setUp(() async {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
      await queryClient.connect();
    });

    tearDownAll(() async {
      await queryClient.disconnect();
    });

    test('Initialization', () {
      expect(queryClient.url, equals("wss://tfchain.dev.grid.tf/ws"));
      expect(queryClient.contracts, isA<QueryContracts>());
      expect(queryClient.balances, isA<QueryBalances>());
      expect(queryClient.farms, isA<QueryFarms>());
      expect(queryClient.nodes, isA<QueryNodes>());
      expect(queryClient.policies, isA<QueryPricingPolicies>());
      expect(queryClient.twins, isA<QueryTwins>());
      expect(queryClient.bridge, isA<QueryBridge>());
      expect(queryClient.price, isA<QueryTFTPrice>());
    });

    test('Connect', () async {
      expect(queryClient.provider, isA<WsProvider>());
      expect(queryClient.api, isNotNull);
    });

    test('Disconnect', () async {
      await queryClient.disconnect();
      expect(false, queryClient.provider!.isConnected());
    });
  });

  group("Full Client Tests", () {
    late Client client;
    final mnemonic = Platform.environment['MNEMONIC']!;
    final String url =
        Platform.environment['URL'] ?? 'wss://tfchain.dev.grid.tf/ws';
    final String type = Platform.environment['KEYPAIR_TYPE'] ?? 'sr25519';
    setUp(() async {
      client = Client(
        url,
        mnemonic,
        type,
      );
      await client.connect();
    });

    tearDownAll(() async {
      await client.disconnect();
    });

    test('Initialization', () {
      expect(client.url, equals("wss://tfchain.dev.grid.tf/ws"));
      expect(client.contracts, isA<Contracts>());
      expect(client.farms, isA<Farms>());
      expect(client.balances, isA<Balances>());
      expect(client.bridge, isA<Bridge>());
      expect(client.dao, isA<Dao>());
    });
    test('Connect', () async {
      expect(client.keypair, isNotNull);
      expect(client.address, isNotEmpty);
      expect(client.provider, isA<WsProvider>());
      expect(client.api, isNotNull);
    });

    test('Disconnect', () async {
      await client.disconnect();
      expect(false, client.provider!.isConnected());
    });
  });
}
