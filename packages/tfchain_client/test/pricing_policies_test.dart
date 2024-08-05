import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/types/pricing_policy.dart';

import 'setup_manager.dart';

void main() {
  group("Query Pricing Policies", () {
    final setupManager = SetupManager();
    setUpAll(() async {
      setupManager.setInitializationFlags(queryClient: true);
      await setupManager.setup();
    });
    test('Test Get Pricing Policy', () async {
      PricingPolicy? res = await setupManager.queryClient.policies.get(id: 1);
      expect(res, isNotNull);
    });

    test('Test Get Pricing Policy with wrong Id', () async {
      try {
        PricingPolicy? res =
            await setupManager.queryClient.policies.get(id: -10);
      } catch (error) {
        expect(error, isNotNull);
      }
    });
  });
}
