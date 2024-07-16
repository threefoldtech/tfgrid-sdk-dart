import 'dart:io';
import 'dart:math';

import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/farm.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Farms Test", () {
    late QueryClient queryClient;
    setUp(() async {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
      await queryClient.connect();
    });

    tearDownAll(() async {
      await queryClient.disconnect();
    });

    test('Test Get Farm by Id', () async {
      Farm? farm = await queryClient.farms.get(id: 1);
      expect(farm, isNotNull);
    });

    test('Test Get Farm by wrong Id', () async {
      try {
        Farm? farm = await queryClient.farms.get(id: -50);
      } catch (e) {
        expect(e, isNotNull);
      }
    });
  });

  group("Test Farms", () {
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
      try {
        await client.farms.removeFarmIp(farmId: 4588, ip: "198.165.15.25/16");
      } catch (error) {
        print("Error removing Ip from farm with id 4588: $error");
      }
      await client.disconnect();
    });

    test('Test create farm', () async {
      final random = Random();
      final farmName = 'farm_${random.nextInt(999)}';
      final farmId = await client.farms.create(name: farmName, publicIps: []);
      expect(farmId, isNotNull);
    });

    test('Test create farm with existing name', () async {
      try {
        final farmId =
            await client.farms.create(name: "hellofarm", publicIps: []);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test adding farm ip', () async {
      try {
        await client.farms.addFarmIp(
            farmId: 4588, ip: "198.165.15.25/16", gw: "198.165.15.26");
      } catch (error) {
        // will fail as the ip already exists
        expect(error, isNotNull);
      }
    });

    test('Test adding farm ip with same ip and gateway', () async {
      try {
        await client.farms.addFarmIp(
            farmId: 4588, ip: "198.165.15.25/16", gw: "198.165.15.25");
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test add stellar address', () async {
      try {
        await client.farms.addStellarAddress(
            farmId: 4588,
            stellarAddress:
                "GDHJP6TF3UXYXTNEZ2P36J5FH7W4BJJQ4AYYAXC66I2Q2AH5B6O6BCFG");
      } catch (error) {
        expect(error, null);
      }
    });
  });
}
