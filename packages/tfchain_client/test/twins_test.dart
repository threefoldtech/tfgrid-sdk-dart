import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/types/twin.dart';

import 'shared_setup.dart';

void main() {
  group("Twins Test", () {
    sharedSetup();

    test('Test Get Twin with id', () async {
      final twin = await client.twins.get(id: twinId!);
      expect(twin!.id, twinId);
    });

    test('Test Get Twin with zero id', () async {
      final twin = await client.twins.get(id: 0);
      expect(twin, null);
    });

    test('Test Get Twin Id with account Id', () async {
      String address = myAddress;
      final twin = await client.twins.getTwinIdByAccountId(address: address);
      expect(twin, twinId);
    });

    test('Test Create Twin for existing account', () async {
      try {
        int? twin = await client.twins.create(relay: "", pk: []);
      } catch (error) {
        expect(
          error,
          isNotNull,
        );
      }
    });
    test('Test Update Twin', () async {
      try {
        await client.twins.update(relay: "relay.qa.grid.tf".codeUnits, pk: []);
        Twin? twin = await client.twins.get(id: twinId!);
        expect(twin!.relay, "relay.qa.grid.tf".codeUnits);
      } catch (error) {
        expect(error, null);
      }
    });
  });
}
