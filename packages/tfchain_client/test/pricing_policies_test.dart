import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/types/pricing_policy.dart';

import 'shared_setup.dart';

void main() {
  group("Query Pricing Policies", () {
    sharedSetup();

    test('Test Get Pricing Policy', () async {
      PricingPolicy? res = await client.policies.get(id: 1);
      expect(res, isNotNull);
    });

    test('Test Get Pricing Policy with wrong Id', () async {
      try {
        PricingPolicy? res = await client.policies.get(id: -10);
      } catch (error) {
        expect(error, isNotNull);
      }
    });
  });
}
