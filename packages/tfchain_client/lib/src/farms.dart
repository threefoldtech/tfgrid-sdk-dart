import 'package:tfchain_client/generated/dev/types/tfchain_runtime/runtime_call.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/farm.dart';
import 'package:tfchain_client/tfchain_client.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/ip4.dart';

class QueryFarms {
  final QueryClient client;
  QueryFarms(this.client);

  Future<Farm?> get({required int id}) async {
    final res = await client.api.query.tfgridModule.farms(id);
    return res as Farm;
  }
}

class Farms extends QueryFarms {
  Farms(Client client) : super(client);

  Future<RuntimeCall> create(
      {required String name, required List<Ip4>? publicIps}) async {
    final extrinsic = client.api.tx.tfgridModule
        .createFarm(name: name.codeUnits, publicIps: publicIps);
    return extrinsic;
  }

// TODO: Bug
  Future<RuntimeCall> addFarmIp(
      {required int farmId, required String ip, required String gw}) async {
    final extrinsic = client.api.tx.tfgridModule
        .addFarmIp(farmId: farmId, ip: ip.codeUnits, gw: gw.codeUnits);
    return extrinsic;
  }

  Future<RuntimeCall> removeFarmIp(
      {required int farmId, required String ip}) async {
    final extrinsic =
        client.api.tx.tfgridModule.removeFarmIp(farmId: farmId, ip: ip);
    return extrinsic;
  }

  Future<RuntimeCall> addStellarAddress(
      {required int farmId, required String stellarAddress}) async {
    final extrinsic = client.api.tx.tfgridModule.addStellarPayoutV2address(
        farmId: farmId, stellarAddress: stellarAddress);
    return extrinsic;
  }
}
