import 'package:polkadart/polkadart.dart';
import 'package:test/test.dart';
import 'package:tfchain_client/src/balances.dart';
import 'package:tfchain_client/src/contracts.dart';
import 'package:tfchain_client/src/dao.dart';
import 'package:tfchain_client/src/farms.dart';
import 'package:tfchain_client/src/kvstore.dart';
import 'package:tfchain_client/src/nodes.dart';
import 'package:tfchain_client/src/pricing_policies.dart';
import 'package:tfchain_client/src/terms_and_conditions.dart';
import 'package:tfchain_client/src/tft_bridge.dart';
import 'package:tfchain_client/src/tft_price.dart';
import 'package:tfchain_client/src/twins.dart';
import 'package:tfchain_client/tfchain_client.dart';

import 'setup_manager.dart';

void main() {
  group('Query Client Tests', () {
    late QueryClient queryClient;
    final setupManager = SetupManager();
    setUpAll(() async {
      await setupManager.setup();
    });

    setUp(() async {
      queryClient = QueryClient(setupManager.url);
      await queryClient.connect();
    });

    test('Initialization', () {
      expect(queryClient.url, equals(setupManager.url));
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
      if (queryClient.provider!.isConnected()) {
        expect(queryClient.provider, isA<WsProvider>());
        expect(queryClient.api, isNotNull);
      }
    });

    test('Disconnect', () async {
      await queryClient.disconnect();
      expect(false, queryClient.provider!.isConnected());
    });
  });

  group("Full Client Tests", () {
    final setupManager = SetupManager();
    setUpAll(() async {
      await setupManager.setup();
    });

    test('Initialization', () {
      expect(setupManager.client.url, equals(setupManager.url));
      expect(setupManager.client.contracts, isA<Contracts>());
      expect(setupManager.client.farms, isA<Farms>());
      expect(setupManager.client.balances, isA<Balances>());
      expect(setupManager.client.bridge, isA<Bridge>());
      expect(setupManager.client.dao, isA<Dao>());
      expect(setupManager.client.kvStore, isA<KVStore>());
      expect(setupManager.client.nodes, isA<Nodes>());
      expect(setupManager.client.termsAndConditions, isA<TermsAndConditions>());
    });
    test('Connect', () async {
      if (setupManager.client.provider!.isConnected()) {
        expect(setupManager.client.keypair, isNotNull);
        expect(setupManager.client.address, isNotEmpty);
        expect(setupManager.client.provider, isA<WsProvider>());
        expect(setupManager.client.api, isNotNull);
      }
    });

    test('Disconnect', () async {
      await setupManager.client.disconnect();
      expect(false, setupManager.client.provider!.isConnected());
    });
  });
}
