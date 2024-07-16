import 'dart:io';

import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/types/twin.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Twins Test", () {
    late QueryClient queryClient;
    setUp(() async {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
      await queryClient.connect();
    });

    tearDownAll(() async {
      await queryClient.disconnect();
    });

    test('Test Get Twin with id', () async {
      int id = 214;
      final twin = await queryClient.twins.get(id: id);
      expect(twin, isNotNull);
    });

    test('Test Get Twin with zero id', () async {
      int id = 0;
      final twin = await queryClient.twins.get(id: id);
      expect(twin, null);
    });

    test('Test Get Twin Id with account Id', () async {
      String address = "5CJrCjZvsudNoJApTGG5PKcZfhAzAyGqgSK8bysoCV2oRBMC";
      final twin =
          await queryClient.twins.getTwinIdByAccountId(address: address);
      expect(twin, 7845);
    });
  });

  group("Twins Test", () {
    late Client client;
    final mnemonic = Platform.environment['MNEMONIC']!;
    final String url =
        Platform.environment['URL'] ?? 'wss://tfchain.dev.grid.tf/ws';
    final String type = Platform.environment['KEYPAIR_TYPE'] ?? 'sr25519';

    setUp(() async {
      client = Client(url, mnemonic, type);
      await client.connect();
    });

    tearDownAll(() async {
      await client.disconnect();
    });

    test('Test Create Twin', () async {
      try {
        int? twin = await client.twins.create(relay: [], pk: []);
      } catch (error) {
        expect(
          error,
          isNotNull,
        );
      }
    });

    test('Test Update Twin', () async {
      try {
        await client.twins.update(relay: "relay.dev.grid.tf".codeUnits, pk: []);
      } catch (error) {
        expect(error, null);
      }
    });
  });
}
