import 'package:gridproxy_client/gridproxy_client.dart';
import 'package:gridproxy_client/models/nodes.dart';
import 'package:gridproxy_client/models/stats.dart';
import 'package:gridproxy_client/models/twins.dart';

import 'gridproxy_client.reflectable.dart';

void main() async {
  initializeReflectable();

  GridProxyClient client = GridProxyClient('https://gridproxy.dev.grid.tf/');

  final res = await client.nodes.getNodeStatistics(nodeID: 161);
  print(res);
}
