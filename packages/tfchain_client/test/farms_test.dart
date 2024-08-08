@Timeout(Duration(seconds: 50))
import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/farm.dart';

import 'shared_setup.dart';

void main() {
  group("Farms Test", () {
    sharedSetup();
    Map<int, String> farmsIps = {};

    test('Test Get Farm by Id', () async {
      int? farmId = await client.farms
          .create(name: generateRandomString(6), publicIps: []);

      Farm? farm = await client.farms.get(id: farmId!);
      expect(farm!.id, farmId);
    });

    test('Test Get Farm by invalid Id', () async {
      try {
        Farm? farm = await client.farms.get(id: -2);
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('Test create farm', () async {
      final farmId = await client.farms
          .create(name: generateRandomString(6), publicIps: []);
      expect(farmId, isNotNull);
    });

    test('Test get farmId by name', () async {
      final name = generateRandomString(6);
      int? farmId = await client.farms.create(name: name, publicIps: []);
      final res = await client.farms.getFarmIdByName(name: name);
      expect(res, farmId!);
    });

    test('Test create farm with existing name', () async {
      try {
        final name = generateRandomString(6);
        await client.farms.create(name: name, publicIps: []);
        final farmId = await client.farms.create(name: name, publicIps: []);
      } catch (error) {
        expect(error, isNotNull);
      }
    }, timeout: Timeout(Duration(seconds: 70)));

    test('Test adding farm ip with equal ip and gateway', () async {
      try {
        final farmId = await client.farms
            .create(name: generateRandomString(6), publicIps: []);
        await client.farms.addFarmIp(
            farmId: farmId!, ip: "198.165.15.29/16", gw: "198.165.15.29");
      } catch (error) {
        expect(error, isNotNull);
      }
    }, timeout: Timeout(Duration(seconds: 50)));

    test('Test adding valid IPs to farm,', () async {
      try {
        int? farmId = await client.farms
            .create(name: generateRandomString(5), publicIps: []);
        await client.farms.addFarmIp(
            farmId: farmId!, ip: "198.165.15.29/16", gw: "198.165.15.26");
        farmsIps[farmId] = "198.165.15.29/16";
      } catch (error) {
        expect(error, isNotNull);
      }
    }, timeout: Timeout(Duration(seconds: 50)));

    test('Test adding existing ips to farm', () async {
      try {
        int? farmId1 = await client.farms
            .create(name: generateRandomString(5), publicIps: []);
        await client.farms.addFarmIp(
            farmId: farmId1!, ip: "198.165.15.29/16", gw: "198.165.15.26");
        farmsIps[farmId1] = "198.165.15.29/16";

        int? farmId2 = await client.farms
            .create(name: generateRandomString(5), publicIps: []);
        await client.farms.addFarmIp(
            farmId: farmId2!, ip: "198.165.15.29/16", gw: "198.165.15.26");
      } catch (error) {
        print(error);
        // will fail as the ip already exists
        expect(error, isNotNull);
      }
    }, timeout: Timeout(Duration(seconds: 50)));

    test('Test removing farm IP', () async {
      try {
        final farmId = await client.farms
            .create(name: generateRandomString(6), publicIps: []);
        await client.farms.addFarmIp(
            farmId: farmId!, ip: "198.165.15.28/16", gw: "198.165.15.29");

        await client.farms.removeFarmIp(farmId: farmId, ip: "198.165.15.28/16");
      } catch (error) {
        expect(error, isNull);
      }
    }, timeout: Timeout(Duration(seconds: 70)));

    test('Test adding Stellar Address', () async {
      try {
        final farmId = await client.farms
            .create(name: generateRandomString(6), publicIps: []);
        await client.farms.addStellarAddress(
            farmId: farmId!,
            stellarAddress:
                "GDHJP6TF3UXYXTNEZ2P36J5FH7W4BJJQ4AYYAXC66I2Q2AH5B6O6BCFG");
      } catch (error) {
        expect(error, isNull);
      }
    });

    tearDown(() async {
      if (farmsIps.isNotEmpty) {
        for (var entry in farmsIps.entries) {
          try {
            await client.farms.removeFarmIp(farmId: entry.key, ip: entry.value);
          } catch (error) {
            print("Error removing IPv4 for farm with Id ${entry.key} : $error");
          }
        }
        farmsIps.clear();
      }
    });
  });
}
