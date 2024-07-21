import 'package:test/test.dart';
import 'package:tfchain_client/tfchain_client.dart';

import 'shared_setup.dart';

void main() {
  group("Query Twins Test", () {
    late QueryClient queryClient;
    sharedSetup();

    setUp(() async {
      queryClient = QueryClient(url);
      await queryClient.connect();
    });

    test('Test Get Twin with id', () async {
      final twin = await queryClient.twins.get(id: twinId);
      expect(twin, isNotNull);
    });

    test('Test Get Twin with zero id', () async {
      final twin = await queryClient.twins.get(id: 0);
      expect(twin, null);
    });

    test('Test Get Twin Id with account Id', () async {
      String address = myAddress;
      final twin =
          await queryClient.twins.getTwinIdByAccountId(address: address);
      expect(twin, 7845);
    });

    tearDownAll(() async {
      await queryClient.disconnect();
    });
  });

  group("Twins Test", () {
    late Client client;
    sharedSetup();

    setUp(() async {
      client = Client(url, mnemonic, type);
      await client.connect();
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
        await client.twins.update(relay: relay.codeUnits, pk: []);
      } catch (error) {
        expect(error, null);
      }
    });

    tearDownAll(() async {
      await client.disconnect();
    });
  });
}
