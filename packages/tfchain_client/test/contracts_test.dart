import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/contract.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/contract_lock.dart';

import 'globals.dart';
import 'setup_manager.dart';

void main() {
  group("Contracts Tests", () {
    late SetupManager setupManager;
    setUpAll(() async {
      setupManager = await getSetupManager();
    });
    List<BigInt> contractIds = [];

    test('Get Contract with wrong id', () async {
      try {
        Contract? contract = await setupManager.client.contracts
            .get(contractId: BigInt.from(-100));
        expect(contract, null);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Get Contract Id by active rent for invalid node id', () async {
      try {
        BigInt? contractId = await setupManager.client.contracts
            .getContractIdByActiveRentForNode(nodeId: -21);
        expect(contractId, isNotNull);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Get active contracts by wrong node id', () async {
      try {
        List<int> contracts =
            await setupManager.client.contracts.getActiveContracts(nodeId: -21);
        expect(contracts, isNotEmpty);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Get contract lock by deleted contract id', () async {
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

    test('Update node contract with wrong data', () async {
      try {
        await setupManager.client.contracts.updateNode(
            contractId: BigInt.from(-200),
            deploymentData: [],
            deploymentHash: []);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Create name contract', () async {
      final name = generateRandomString(6);
      final contractId =
          await setupManager.client.contracts.createName(name: name);
      contractIds.add(contractId!);
      expect(contractId, isNotNull);
    }, timeout: Timeout(Duration(seconds: 40)));

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
}
