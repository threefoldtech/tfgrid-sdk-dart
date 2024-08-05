import 'package:tfchain_client/generated/dev/types/tfchain_support/types/ip4.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/ip6.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/node.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/power.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/public_config.dart';
import 'package:tfchain_client/tfchain_client.dart';

class QueryNodes {
  final QueryClient client;
  QueryNodes(this.client);

  Future<Node?> get({required int id}) async {
    if (id.isNaN || id <= 0) {
      throw Exception("Invalid node id. Node id must be a positive integer");
    }
    final res = await client.api.query.tfgridModule.nodes(id);
    return res as Node;
  }
}

class Nodes extends QueryNodes {
  Nodes(Client this.client) : super(client);
  final Client client;

  Future<void> setPower({required int nodeId, required bool power}) async {
    Power _power;
    if (power) {
      _power = Power.up;
    } else {
      _power = Power.down;
    }
    final extrinsic = client.api.tx.tfgridModule
        .changePowerTarget(nodeId: nodeId, powerTarget: _power);
    await client.apply(extrinsic);
  }

  Future<void> addNodePublicConfig({
    required int farmId,
    required int nodeId,
    required String ip4Ip,
    required String ip4Gw,
    String? ip6Ip,
    String? ip6Gw,
    String? domain,
  }) async {
    Ip4 ip4Config = Ip4(ip: ip4Ip.codeUnits, gw: ip4Gw.codeUnits);
    Ip6? ip6Config;

    if (ip6Ip != null && ip6Gw != null) {
      ip6Config = Ip6(ip: ip6Ip.codeUnits, gw: ip6Gw.codeUnits);
    }

    PublicConfig publicConfig = PublicConfig(
      ip4: ip4Config,
      ip6: ip6Config,
      domain: domain!.codeUnits,
    );

    final extrinsic = client.api.tx.tfgridModule.addNodePublicConfig(
        farmId: farmId, nodeId: nodeId, publicConfig: publicConfig);
    await client.apply(extrinsic);
  }
}
