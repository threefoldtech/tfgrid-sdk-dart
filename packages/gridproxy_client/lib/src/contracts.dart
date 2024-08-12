import 'package:gridproxy_client/gridproxy_client.dart';
import 'package:gridproxy_client/models/contracts.dart';

class Contracts {
  final GridProxyClient client;

  Contracts(this.client);

  Future<List<ContractInfo>> getContracts(
      ContractInfoQueryParams queryParameters) async {
    final response =
        await client.getRequest('/contracts', queryParameters.toMap());
    List<ContractInfo> contracts =
        (response as List<dynamic>).map((contractsData) {
      return ContractInfo.fromJson(contractsData as Map<String, dynamic>);
    }).toList();
    return contracts;
  }

  Future<ContractInfo> getContractByID(int contractId) async {
    final response = await client.getRequest('/contracts/$contractId', null);
    ContractInfo contract =
        ContractInfo.fromJson(response as Map<String, dynamic>);
    return contract;
  }

  Future<List<ContractBills>> getContractBills(
      int contractId, ContractBillQueryParams queryParameters) async {
    final response = await client.getRequest(
        '/contracts/$contractId/bills', queryParameters.toMap());
    List<ContractBills> contractsBills =
        (response as List<dynamic>).map((contractsData) {
      return ContractBills.fromJson(contractsData as Map<String, dynamic>);
    }).toList();
    return contractsBills;
  }
}
