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
    return res;
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
        .contractIDByNameRegistration(name.codeUnits);
    return res;
  }

  Future<BigInt?> getContractIdByNodeIdAndHash(
      {required int nodeId, required List<int> hash}) async {
    final res = await client.api.query.smartContractModule
        .contractIDByNodeIDAndHash(nodeId, hash);
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
    } else if (contract == null) {
      return 0;
    }

    //TODO: double check that GracePeriod typed like that.
    final blockNumber = contract.state.toJson()["GracePeriod"];
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

class Contracts extends QueryContracts {
  Contracts(Client this.client) : super(client);
  final Client client;

  // TODO: should i return bigint or convert it to int ??
  Future<BigInt?> createNode(
      {required int nodeId,
      required List<int> deploymentHash,
      required List<int> deploymentData,
      required int publicIps,
      BigInt? solutionProviderId}) async {
    final extrinsic = client.api.tx.smartContractModule.createNodeContract(
        nodeId: nodeId,
        deploymentHash: deploymentHash,
        deploymentData: deploymentData,
        publicIps: publicIps,
        solutionProviderId: solutionProviderId!);
    await client.apply(extrinsic);

    return await getContractIdByNodeIdAndHash(
        hash: deploymentHash, nodeId: nodeId);
  }

  Future<void> updateNode(
      {required int contractId,
      required List<int> deploymentHash,
      required List<int> deploymentData}) async {
    final extrinsic = client.api.tx.smartContractModule.updateNodeContract(
        contractId: contractId,
        deploymentHash: deploymentHash,
        deploymentData: deploymentData);
    await client.apply(extrinsic);
  }

  Future<BigInt?> createName({required String name}) async {
    final extrinsic = client.api.tx.smartContractModule
        .createNameContract(name: name.codeUnits);
    await client.apply(extrinsic);

    return await getContractIdByName(name: name);
  }

  Future<BigInt?> createRent(
      {required int nodeId, required BigInt solutionProviderId}) async {
    final extrinsic = client.api.tx.smartContractModule.createRentContract(
        nodeId: nodeId, solutionProviderId: solutionProviderId);
    await client.apply(extrinsic);

    return await getContractIdByActiveRentForNode(nodeId: nodeId);
  }

  Future<void> cancel({required BigInt contractId}) async {
    final contract = await get(contractId: contractId);
    if (contract == null) {
      throw Exception("Contract not found");
    }

    final extrinsic = client.api.tx.smartContractModule
        .cancelContract(contractId: contractId);
    await client.apply(extrinsic);
  }

  Future<void> setDedicatedNodeExtraFee(
      {required int nodeId, required BigInt extraFee}) async {
    final extrinsic = client.api.tx.smartContractModule
        .setDedicatedNodeExtraFee(nodeId: nodeId, extraFee: extraFee);
    await client.apply(extrinsic);
  }
}
