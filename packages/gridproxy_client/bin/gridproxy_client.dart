import 'package:gridproxy_client/gridproxy_client.dart';
import 'package:gridproxy_client/models/contracts.dart';
import 'package:gridproxy_client/models/nodes.dart';

void main() async {
  GridProxyClient client = GridProxyClient('gridproxy.dev.grid.tf');
  await client.nodes.getNodeStatus(GetNodeStatusOptions(nodeID: 72));
  await client.contracts.getContracts(ContractInfoQueryParams(
      page: 1,
      size: 2,
      retCount: true,
      sortBy: ContractSortBy.state,
      sortOrder: ContractSortOrder.desc,
      type: ContractTypes.rent,
      state: ContractState.Deleted));
  await client.contracts.getContractByID(119696);
  await client.contracts.getContractBills(
      138360, ContractBillQueryParams(size: 2, page: 4, retCount: false));
}
