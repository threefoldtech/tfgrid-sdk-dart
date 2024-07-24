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

import 'shared_setup.dart';

void main() {
  group('Query Client Tests', () {
    late QueryClient queryClient;
    sharedSetup();

    setUp(() async {
      queryClient = QueryClient(url);
      await queryClient.connect();
    });

    test('Initialization', () {
      expect(queryClient.url, equals(url));
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
    sharedSetup();
    test('Initialization', () {
      expect(client.url, equals(url));
      expect(client.contracts, isA<Contracts>());
      expect(client.farms, isA<Farms>());
      expect(client.balances, isA<Balances>());
      expect(client.bridge, isA<Bridge>());
      expect(client.dao, isA<Dao>());
      expect(client.kvStore, isA<KVStore>());
      expect(client.nodes, isA<Nodes>());
      expect(client.termsAndConditions, isA<TermsAndConditions>());
    });
    test('Connect', () async {
      if (client.provider!.isConnected()) {
        expect(client.keypair, isNotNull);
        expect(client.address, isNotEmpty);
        expect(client.provider, isA<WsProvider>());
        expect(client.api, isNotNull);
      }
    });

    test('Disconnect', () async {
      await client.disconnect();
      expect(false, client.provider!.isConnected());
    });
  });
}
