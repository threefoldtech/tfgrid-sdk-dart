@Timeout(Duration(seconds: 50))
import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/contract.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/contract_lock.dart';

import 'setup_manager.dart';

void main() {
  group("Contracts Tests", () {
    // sharedSetup();
    final setupManager = SetupManager();
    setUpAll(() async {
      await setupManager.setup();
    });
    List<BigInt> contractIds = [];

    test('Test Get Contract with wrong id', () async {
      try {
        Contract? contract = await setupManager.client.contracts
            .get(contractId: BigInt.from(-100));
        expect(contract, null);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Contract Id by active rent for invalid node id', () async {
      try {
        BigInt? contractId = await setupManager.client.contracts
            .getContractIdByActiveRentForNode(nodeId: -21);
        expect(contractId, isNotNull);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Active Contracts by wrong node Id', () async {
      try {
        List<int> contracts =
            await setupManager.client.contracts.getActiveContracts(nodeId: -21);
        expect(contracts, isNotEmpty);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Contract Lock by deleted Contract Id', () async {
      try {
        final name = generateRandomString(7);
        BigInt? contractId =
            await setupManager.client.contracts.createName(name: name);
        contractIds.add(contractId!);
        await setupManager.client.contracts.cancel(contractId: contractId);
        contractIds.remove(contractId);
        ContractLock? contractLock =
            await setupManager.client.contracts.contractLock(id: contractId);
      } catch (error) {
        expect(error, isNotNull);
      }
    }, timeout: Timeout(Duration(seconds: 50)));

    test('Test Update Node Contract with wrong data', () async {
      try {
        await setupManager.client.contracts.updateNode(
            contractId: BigInt.from(-200),
            deploymentData: [],
            deploymentHash: []);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Create Name Contract', () async {
      final name = generateRandomString(6);
      final contractId =
          await setupManager.client.contracts.createName(name: name);
      contractIds.add(contractId!);
      expect(contractId, isNotNull);
    });

    tearDown(() async {
      if (contractIds.isNotEmpty) {
        for (BigInt contractId in contractIds) {
          try {
            await setupManager.client.contracts.cancel(contractId: contractId);
          } catch (error) {
            print("Error canceling contract with Id $contractId : $error");
          }
        }
      }
    });
  });
  // group("Query Contracts Test", () {
  // test('Test Get Deleted Contract by Id', () async {
  //   Contract? contract =
  //       await queryClient.contracts.get(contractId: deletedContract);
  //   expect(contract, null);
  // });

  // test('Test Get Active Contracts by node Id', () async {
  //   List<int> contracts =
  //       await queryClient.contracts.getActiveContracts(nodeId: nodeId);
  //   print(contracts);
  //   expect(contracts, isNotEmpty);
  // });

  // test('Test Get Contract Id by name', () async {
  //   try {

  //     BigInt? contractId =
  //         await queryClient.contracts.getContractIdByName(name: nameContract);
  //     expect(contractId, isNotEmpty);
  //   } catch (error) {
  //     expect(error, isNotNull);
  //   }
  // });

  // test('Test Get Contract Id by node Id and hash', () async {
  //   try {
  //     BigInt? contractId = await queryClient.contracts
  //         .getContractIdByNodeIdAndHash(nodeId: nodeId, hash: []);
  //     expect(contractId, isNotEmpty);
  //   } catch (error) {
  //     expect(error, isNotNull);
  //   }
  // });

  // test('Test Get a Dedicated Node extra fee', () async {
  //   BigInt? fee =
  //       await queryClient.contracts.getDedicatedNodeExtraFee(nodeId: myNode);
  //   expect(fee, isNotNull);
  // });

  // tearDownAll(() async {
  //   await queryClient.disconnect();
  // });
  // });

  // group("Test Contracts", () {

  // test('Test Create Node Contract with empty data', () async {
  //   // TODO: should create node for it
  //   try {
  //     BigInt? contractId = await client.contracts.createNode(
  //         nodeId: 11, deploymentData: [], deploymentHash: [], publicIps: 0);
  //   } catch (error) {
  //     expect(error, isNotNull);
  //   }
  // });

  // test('Test Create Rent Contract with no solution provider', () async {
  //   // TODO: create node first
  //   try {
  //     BigInt? contractId = await client.contracts
  //         .createRent(nodeId: rentNode, solutionProviderId: BigInt.zero);
  //   } catch (error) {
  //     expect(error.toString(), contains('NoSuchSolutionProvider'));
  //   }
  // });

  // test('Test set dedicated node extra fee', () async {
  //   // TODO: create dedicated node first
  //   try {
  //     await client.contracts
  //         .setDedicatedNodeExtraFee(nodeId: myNode, extraFee: BigInt.two);
  //   } catch (error) {
  //     expect(error, isNotNull);
  //   }
  // });
  // });
}
