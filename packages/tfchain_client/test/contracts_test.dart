import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/contract.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/contract_lock.dart';
import 'package:tfchain_client/tfchain_client.dart';

import 'shared_setup.dart';

void main() {
  group("Query Contracts Test", () {
    late QueryClient queryClient;
    sharedSetup();

    setUp(() async {
      queryClient = QueryClient(url);
      await queryClient.connect();
    });

    test('Test Get Deleted Contract by Id', () async {
      Contract? contract =
          await queryClient.contracts.get(contractId: deletedContract);
      expect(contract, null);
    });

    test('Test Get Contract with wrong id', () async {
      try {
        Contract? contract =
            await queryClient.contracts.get(contractId: invalidContractId);
        expect(contract, null);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Contract Id by active rent for invalid node id', () async {
      try {
        BigInt? contractId = await queryClient.contracts
            .getContractIdByActiveRentForNode(nodeId: invalidNodeId);
        expect(contractId, isNotNull);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Active Contracts by node Id', () async {
      List<int> contracts =
          await queryClient.contracts.getActiveContracts(nodeId: nodeId);
      print(contracts);
      expect(contracts, isNotEmpty);
    });

    test('Test Get Active Contracts by wrong node Id', () async {
      try {
        List<int> contracts = await queryClient.contracts
            .getActiveContracts(nodeId: invalidNodeId);
        expect(contracts, isNotEmpty);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Contract Id by name', () async {
      try {
        BigInt? contractId =
            await queryClient.contracts.getContractIdByName(name: nameContract);
        expect(contractId, isNotEmpty);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Contract Id by node Id and hash', () async {
      try {
        BigInt? contractId = await queryClient.contracts
            .getContractIdByNodeIdAndHash(nodeId: nodeId, hash: []);
        expect(contractId, isNotEmpty);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Contract Lock by deleted Contract Id', () async {
      try {
        ContractLock? contractLock =
            await queryClient.contracts.contractLock(id: deletedContract);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get a Dedicated Node extra fee', () async {
      BigInt? fee =
          await queryClient.contracts.getDedicatedNodeExtraFee(nodeId: myNode);
      expect(fee, isNotNull);
    });

    tearDownAll(() async {
      await queryClient.disconnect();
    });
  });

  group("Test Contracts", () {
    late Client client;
    BigInt? contractId = null;
    sharedSetup();

    setUp(() async {
      client = Client(url, mnemonic, type);
      await client.connect();
    });

    test('Test Create Node Contract with empty data', () async {
      try {
        BigInt? contractId = await client.contracts.createNode(
            nodeId: 11, deploymentData: [], deploymentHash: [], publicIps: 0);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Update Node Contract with wrong data', () async {
      try {
        await client.contracts.updateNode(
            contractId: invalidContractId,
            deploymentData: [],
            deploymentHash: []);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Create Name Contract', () async {
      contractId =
          await client.contracts.createName(name: generateRandomString(4));
      expect(contractId, isNotNull);
    });

    test('Test Create Rent Contract with no solution provider', () async {
      try {
        BigInt? contractId = await client.contracts
            .createRent(nodeId: rentNode, solutionProviderId: BigInt.zero);
      } catch (error) {
        expect(error.toString(), contains('NoSuchSolutionProvider'));
      }
    });

    test('Test set dedicated node extra fee', () async {
      try {
        await client.contracts
            .setDedicatedNodeExtraFee(nodeId: myNode, extraFee: BigInt.two);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    tearDown(() async {
      if (contractId != null) {
        try {
          await client.contracts.cancel(contractId: contractId!);
        } catch (error) {
          print("Error canceling contract: $error");
        }
      }
    });

    tearDownAll(() async {
      await client.disconnect();
    });
  });
}
