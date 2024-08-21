import 'package:gridproxy_client/gridproxy_client.dart';
import 'package:gridproxy_client/models/farms.dart';


void main() async {
  GridProxyClient client = GridProxyClient('gridproxy.dev.grid.tf');

  final options = ListFarmsQueryParameters(farmId: 1);
  final farms = await client.farms.listFarms(options);

  print(farms);
}
