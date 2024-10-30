import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/types/pricing_policy.dart';

import 'globals.dart';
import 'setup_manager.dart';

void main() {
  group("Query Pricing Policies", () {
    late SetupManager setupManager;
    setUpAll(() async {
      setupManager = await getSetupManager();
    });
    test('Get Pricing Policy', () async {
      PricingPolicy? res = await setupManager.queryClient.policies.get(id: 1);
      expect(res, isNotNull);
    });

    test('Get Pricing Policy with wrong Id', () async {
      try {
        PricingPolicy? res =
            await setupManager.queryClient.policies.get(id: -10);
      } catch (error) {
        expect(error, isNotNull);
      }
    });
  });
}
