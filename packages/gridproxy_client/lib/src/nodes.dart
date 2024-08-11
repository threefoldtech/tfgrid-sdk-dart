import 'package:gridproxy_client/gridproxy_client.dart';
import 'package:gridproxy_client/models/nodes.dart';

class Nodes {
  final GridProxyClient client;

  Nodes(this.client);

  Future<void> getNodeStatus(GetNodeStatusOptions options) async {
    final nodeStatus = await client.getRequest('/nodes/72/status', null);
    print(nodeStatus['status']);
  }

  Future<List<Node>> listNodes(ListNodesQueryParamaters? queryParams) async {
    final nodes = await client.getRequest(
        '/nodes', queryParams?.toQueryParamaters()) as List<dynamic>;
    return nodes.map((node) => Node.fromJson(node)).toList();
  }

  Future<Node> getNode(int nodeID) async {
    final node = await client.getRequest('/nodes/$nodeID', null);
    return Node.fromJson(node);
  }

  Future<List<NodeGPUInfo>> listNodeGPUs(int nodeID) async {
    final nodeGPUs =
        await client.getRequest('/nodes/$nodeID/gpu', null) as List<dynamic>;
    return nodeGPUs.map((gpu) => NodeGPUInfo.fromJson(gpu)).toList();
  }

  Future<NodeStatistics> getNodeStatistics(int nodeID) async {
    final nodeStatistics =
        await client.getRequest('/nodes/$nodeID/statistics', null);
    return NodeStatistics.fromJson(nodeStatistics);
  }
}
