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

    tearDown(() async {
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
    final String link =
        Platform.environment['LINK'] ?? 'wss://tfchain.dev.grid.tf/ws';
    final String type = Platform.environment['SIGN_TYPE'] ?? 'sr25519';

    setUp(() async {
      client = Client(link, mnemonic, type);
      await client.connect();
    });

    tearDown(() async {
      await client.disconnect();
    });

    test('Test Create Twin', () async {
      try {
        int? twin = await client.twins.create(relay: [], pk: []);
      } catch (error) {
        expect(
          error.toString(),
          startsWith('Failed to apply extrinsic:'),
        );
      }
    });

    test('Test Update Twin', () async {
      Twin? twin = await client.twins
          .update(relay: "relay.dev.grid.tf".codeUnits, pk: []);
      expect(twin, isNotNull);
    });
  });
}
