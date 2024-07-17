import 'dart:io';

import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/farm.dart';
import 'package:tfchain_client/tfchain_client.dart';

import 'shared_setup.dart';

void main() {
  group("Query Farms Test", () {
    late QueryClient queryClient;
    sharedSetup();

    setUp(() async {
      queryClient = QueryClient(url);
      await queryClient.connect();
    });

    test('Test Get Farm by Id', () async {
      Farm? farm = await queryClient.farms.get(id: farmId);
      expect(farm, isNotNull);
    });

    test('Test Get Farm by invalid Id', () async {
      try {
        Farm? farm = await queryClient.farms.get(id: -invalidFarmId);
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    tearDownAll(() async {
      await queryClient.disconnect();
    });
  });

  group("Test Farms", () {
    late Client client;
    sharedSetup();

    setUp(() async {
      client = Client(url, mnemonic, type);
      await client.connect();
    });

    test('Test create farm', () async {
      final farmId = await client.farms
          .create(name: generateRandomString(6), publicIps: []);
      expect(farmId, isNotNull);
    });

    test('Test create farm with existing name', () async {
      try {
        final farmId =
            await client.farms.create(name: existingFarmName, publicIps: []);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test adding existing ips to farm', () async {
      try {
        await client.farms
            .addFarmIp(farmId: myFarmId, ip: existingIPv4, gw: gw4);
      } catch (error) {
        // will fail as the ip already exists
        expect(error, isNotNull);
      }
    });

    test('Test adding farm ip with equal ip and gateway', () async {
      try {
        await client.farms
            .addFarmIp(farmId: myFarmId, ip: validIPv4, gw: InvalidGateway);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test adding valid IPs to far,', () async {
      try {
        await client.farms.addFarmIp(farmId: myFarmId, ip: validIPv4, gw: gw4);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test add stellar address', () async {
      try {
        await client.farms
            .addStellarAddress(farmId: 4588, stellarAddress: stellarAddress);
      } catch (error) {
        expect(error, null);
      }
    });

    tearDownAll(() async {
      try {
        await client.farms.removeFarmIp(farmId: myFarmId, ip: validIPv4);
      } catch (error) {
        print("Error removing Ip from farm with id ${myFarmId}: $error");
      }
      await client.disconnect();
    });
  });
}
