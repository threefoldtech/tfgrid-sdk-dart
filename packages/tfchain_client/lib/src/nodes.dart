import 'package:tfchain_client/generated/dev/types/tfchain_support/types/node.dart';
import 'package:tfchain_client/models/nodes.dart';
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
    Map<String, bool?> powerTarget = {
      'up': null,
      'down': null,
    };
    if (power) {
      powerTarget['up'] = true;
    } else {
      powerTarget['down'] = true;
    }
    final extrinsic = client.api.tx.tfgridModule
        .changePowerTarget(nodeId: nodeId, powerTarget: powerTarget);
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
    IPConfig ip4Config = IPConfig(ip: ip4Ip, gw: ip4Gw);
    IPConfig? ip6Config;

    if (ip6Ip != null && ip6Gw != null) {
      ip6Config = IPConfig(ip: ip6Ip, gw: ip6Gw);
    }

    PublicConfig publicConfig = PublicConfig(
      ip4: ip4Config,
      ip6: ip6Config,
      domain: domain,
    );

    NodePublicConfigOptions options = NodePublicConfigOptions(
      farmId: farmId,
      nodeId: nodeId,
      publicConfig: publicConfig,
    );

    final extrinsic = client.api.tx.tfgridModule.addNodePublicConfig(
        farmId: farmId, nodeId: nodeId, publicConfig: options);
    await client.apply(extrinsic);
  }
}
