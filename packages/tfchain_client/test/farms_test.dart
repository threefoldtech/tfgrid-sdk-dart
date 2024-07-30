@Timeout(Duration(seconds: 70))
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
        final randomIp = generateRandomCIDRIPv4();
        final gatewayIp = randomIp.split('/')[0];
        final farmId = await client.farms
            .create(name: generateRandomString(6), publicIps: []);
        await client.farms
            .addFarmIp(farmId: farmId!, ip: randomIp, gw: gatewayIp);
      } catch (error) {
        expect(error, isNotNull);
      }
    }, timeout: Timeout(Duration(seconds: 50)));

    test('Test adding valid IPs to farm,', () async {
      try {
        final randomIp = generateRandomCIDRIPv4();
        final ip = randomIp.split('/')[0];
        final gatewayIp = generateGatewayIPv4FromIp(ip);

        int? farmId = await client.farms
            .create(name: generateRandomString(5), publicIps: []);
        await client.farms.addFarmIp(
            farmId: farmId!, ip: "229.113.17.214/26", gw: "229.113.17.221");
        farmsIps[farmId] = randomIp;
      } catch (error) {
        expect(error, isNotNull);
      }
    }, timeout: Timeout(Duration(seconds: 50)));

    test('Test adding existing ips to farm', () async {
      try {
        int? farmId1 = await client.farms
            .create(name: generateRandomString(5), publicIps: []);

        final randomIp = generateRandomCIDRIPv4();
        final ip = randomIp.split('/')[0];
        final gatewayIp = generateGatewayIPv4FromIp(ip);

        await client.farms
            .addFarmIp(farmId: farmId1!, ip: randomIp, gw: gatewayIp);
        farmsIps[farmId1] = ip;

        int? farmId2 = await client.farms
            .create(name: generateRandomString(5), publicIps: []);
        await client.farms
            .addFarmIp(farmId: farmId2!, ip: randomIp, gw: gatewayIp);
      } catch (error) {
        print(error);
        // will fail as the ip already exists
        expect(error, isNotNull);
      }
    }, timeout: Timeout(Duration(seconds: 100)));

    test('Test removing farm IP', () async {
      try {
        final randomIp = generateRandomCIDRIPv4();
        final ip = randomIp.split('/')[0];

        final gatewayIp = generateGatewayIPv4FromIp(ip);

        print(randomIp);
        print(gatewayIp);

        final farmId = await client.farms
            .create(name: generateRandomString(6), publicIps: []);

        await client.farms
            .addFarmIp(farmId: farmId!, ip: randomIp, gw: gatewayIp);

        await client.farms.removeFarmIp(farmId: farmId, ip: randomIp);
      } catch (error) {
        expect(error, isNull);
      }
    }, timeout: Timeout(Duration(seconds: 100)));

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
    }, timeout: Timeout(Duration(seconds: 50)));

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
