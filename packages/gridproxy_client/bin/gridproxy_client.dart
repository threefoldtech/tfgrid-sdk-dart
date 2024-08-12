import 'package:gridproxy_client/gridproxy_client.dart';
import 'package:gridproxy_client/models/nodes.dart';

void main() async {
  GridProxyClient client = GridProxyClient('gridproxy.dev.grid.tf');

  final options = ListNodesQueryParamaters(gpuAvailable: true);
  final nodes = await client.nodes.listNodes(options);

  //final node = await client.nodes.getNode(64);

  //final nodeGPUs = await client.nodes.listNodeGPUs(179);

  // nodeStatistics = await client.nodes.getNodeStatistics(179);

  print(nodes);
}
