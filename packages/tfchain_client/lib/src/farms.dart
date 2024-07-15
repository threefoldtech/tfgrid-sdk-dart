import 'package:tfchain_client/generated/dev/types/tfchain_support/types/farm.dart';
import 'package:tfchain_client/tfchain_client.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/ip4.dart';

class QueryFarms {
  final QueryClient client;
  QueryFarms(this.client);

  Future<Farm?> get({required int id}) async {
    final res = await client.api.query.tfgridModule.farms(id);
    return res;
  }

  Future<int?> getFarmIdByName({required String name}) async {
    return await client.api.query.tfgridModule.farmIdByName(name.codeUnits);
  }
}

class Farms extends QueryFarms {
  Farms(Client this.client) : super(client);
  final Client client;

  Future<int?> create(
      {required String name, required List<Ip4>? publicIps}) async {
    final extrinsic = client.api.tx.tfgridModule
        .createFarm(name: name.codeUnits, publicIps: publicIps);
    await client.apply(extrinsic);

    return await getFarmIdByName(name: name);
  }

  Future<Farm?> addFarmIp(
      {required int farmId, required String ip, required String gw}) async {
    final extrinsic = client.api.tx.tfgridModule
        .addFarmIp(farmId: farmId, ip: ip.codeUnits, gw: gw.codeUnits);
    await client.apply(extrinsic);

    return await get(id: farmId);
  }

  Future<void> removeFarmIp({required int farmId, required String ip}) async {
    final extrinsic = client.api.tx.tfgridModule
        .removeFarmIp(farmId: farmId, ip: ip.codeUnits);
    await client.apply(extrinsic);
  }

  Future<void> addStellarAddress(
      {required int farmId, required String stellarAddress}) async {
    final extrinsic = client.api.tx.tfgridModule.addStellarPayoutV2address(
        farmId: farmId, stellarAddress: stellarAddress.codeUnits);
    await client.apply(extrinsic);
  }
}
