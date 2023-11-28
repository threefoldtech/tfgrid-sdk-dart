import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/grid_contract/name_contract_name.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/contract.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/contract_lock.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/service_contract.dart';
import 'package:tfchain_client/tfchain_client.dart';

const twoWeeks = 1209600000;

class QueryContracts {
  final QueryClient client;
  QueryContracts(this.client);

  Future<Contract?> get({required BigInt contractId}) async {
    final res =
        await client.api.query.smartContractModule.contracts(contractId);
    return res as Contract;
  }

  Future<BigInt?> getContractIdByActiveRentForNode(
      {required int nodeId}) async {
    final res = await client.api.query.smartContractModule
        .activeRentContractForNode(nodeId);
    return res;
  }

  Future<List<int>> getActiveContracts({required int nodeId}) async {
    final res =
        await client.api.query.smartContractModule.activeNodeContracts(nodeId);
    return res;
  }

  Future<BigInt?> getContractIdByName({required String name}) async {
    final res = await client.api.query.smartContractModule
        .contractIDByNameRegistration(name as NameContractName);
    return res;
  }

  Future<BigInt?> getContractIdByNodeIdAndHash(
      {required int nodeId, required String hash}) async {
    final res = await client.api.query.smartContractModule
        .contractIDByNodeIDAndHash(nodeId, hash as List<int>);
    return res;
  }

  Future<ContractLock?> contractLock({required BigInt id}) async {
    final res = await client.api.query.smartContractModule.contractLock(id);
    return res;
  }

  Future<num> getDeletionTime({required BigInt id}) async {
    final contract = await get(contractId: id);
    if (contract != null && contract.state.toJson()["Created"] == null) {
      return 0;
    }

    //TODO: double check that GracePeriod typed like that.
    final blockNumber = contract!.state.toJson()["GracePeriod"];
    try {
      final currentBlockNumber = await client.api.query.system.number();

      // each block takes 6 seconds
      final gracePeriodStartTime = DateTime.now().millisecondsSinceEpoch -
          (currentBlockNumber - blockNumber) * 6000;
      return gracePeriodStartTime + twoWeeks;
    } catch (e) {
      throw Exception(
          "Error getting current block number for contract $id deletion: $e");
    }
  }

  Future<ServiceContract?> getService({required BigInt serviceId}) async {
    final res =
        await client.api.query.smartContractModule.serviceContracts(serviceId);
    return res;
  }

  Future<BigInt?> getDedicatedNodeExtraFee({required int nodeId}) async {
    final res = await client.api.query.smartContractModule
        .dedicatedNodesExtraFee(nodeId);
    return res;
  }
}
