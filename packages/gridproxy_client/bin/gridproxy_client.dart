import 'package:gridproxy_client/gridproxy_client.dart';
import 'package:gridproxy_client/models/farms.dart';

void main() async {
  GridProxyClient client = GridProxyClient('gridproxy.dev.grid.tf');

  final options = ListFarmsQueryParameters(farmID: 1);
  final farms = await client.farms.list(options);

  print(farms);
}
