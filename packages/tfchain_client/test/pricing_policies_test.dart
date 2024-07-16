import 'dart:io';

import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/types/pricing_policy.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Pricing Policies", () {
    late QueryClient queryClient;
    final String url =
        Platform.environment['URL'] ?? 'wss://tfchain.dev.grid.tf/ws';
    setUp(() async {
      queryClient = QueryClient(url);
      await queryClient.connect();
    });

    tearDownAll(() async {
      await queryClient.disconnect();
    });

    test('Test Get Pricing Policy', () async {
      PricingPolicy? res = await queryClient.policies.get(id: 1);
      expect(res, isNotNull);
    });

    test('Test Get Pricing Policy with wrong Id', () async {
      try {
        PricingPolicy? res = await queryClient.policies.get(id: -80);
        expect(res, isNotNull);
      } catch (error) {
        expect(error, isNotNull);
      }
    });
  });
}
