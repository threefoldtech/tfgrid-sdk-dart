import 'package:gridproxy_client/gridproxy_client.dart';
import 'package:gridproxy_client/models/contracts.dart';
import 'package:gridproxy_client/models/farms.dart';
import 'package:gridproxy_client/models/nodes.dart';
import 'package:gridproxy_client/models/stats.dart';

void main() async {
  GridProxyClient client = GridProxyClient('gridproxy.dev.grid.tf');

  // final options = ListNodesQueryParamaters(gpuAvailable: true);
  // final nodes = await client.nodes.listNodes(options);


  //final node = await client.nodes.getNode(64);

  //final nodeGPUs = await client.nodes.listNodeGPUs(179);

  // nodeStatistics = await client.nodes.getNodeStatistics(179);

  final options = ListFarmsQueryParameters(farmId: 1);
  final farms = await client.farms.listFarms(options);

  print(farms);
}
