import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/types/twin.dart';

import 'setup_manager.dart';

void main() {
  group("Twins Test", () {
    final setupManager = SetupManager();
    setUpAll(() async {
      await setupManager.setup();
    });

    test('Test Get Twin with id', () async {
      final twin =
          await setupManager.client.twins.get(id: setupManager.twinId!);
      expect(twin!.id, setupManager.twinId);
    });

    test('Test Get Twin with zero id', () async {
      final twin = await setupManager.client.twins.get(id: 0);
      expect(twin, null);
    });

    test('Test Get Twin Id with account Id', () async {
      String address = setupManager.myAddress;
      final twin = await setupManager.client.twins
          .getTwinIdByAccountId(address: address);
      expect(twin, setupManager.twinId);
    });

    test('Test Create Twin for existing account', () async {
      try {
        int? twin = await setupManager.client.twins.create(relay: "", pk: []);
      } catch (error) {
        expect(
          error,
          isNotNull,
        );
      }
    });
    test('Test Update Twin', () async {
      try {
        await setupManager.client.twins
            .update(relay: "relay.qa.grid.tf".codeUnits, pk: []);
        Twin? twin =
            await setupManager.client.twins.get(id: setupManager.twinId!);
        expect(twin!.relay, "relay.qa.grid.tf".codeUnits);
      } catch (error) {
        expect(error, null);
      }
    });
  });
}
