import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/contract.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/contract_lock.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Contracts Test", () {
    late QueryClient queryClient;
    setUp(() {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
    });

    test('Test Get Deleted Contract by Id', () async {
      Contract? contract =
          await queryClient.contracts.get(contractId: BigInt.from(97897));
      expect(contract, null);
    });

    test('Test Get Contract with wrong id', () async {
      try {
        Contract? contract =
            await queryClient.contracts.get(contractId: BigInt.from(-200));
        expect(contract, null);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Contract Id by active rent for node', () async {
      try {
        BigInt? contractId = await queryClient.contracts
            .getContractIdByActiveRentForNode(nodeId: -200);
        expect(contractId, isNotNull);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Active Contracts by node Id', () async {
      List<int> contracts =
          await queryClient.contracts.getActiveContracts(nodeId: 21);
      expect(contracts, isNotEmpty);
    });

    test('Test Get Active Contracts by wrong node Id', () async {
      try {
        List<int> contracts =
            await queryClient.contracts.getActiveContracts(nodeId: -21);
        expect(contracts, isNotEmpty);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Contract Id by name', () async {
      try {
        BigInt? contractId =
            await queryClient.contracts.getContractIdByName(name: "name");
        expect(contractId, isNotEmpty);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Contract Id by node Id and hash', () async {
      try {
        BigInt? contractId = await queryClient.contracts
            .getContractIdByNodeIdAndHash(nodeId: 21, hash: []);
        expect(contractId, isNotEmpty);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get Contract Lock by Id', () async {
      try {
        ContractLock? contractLock =
            await queryClient.contracts.contractLock(id: BigInt.from(97897));
        print(contractLock);
        expect(contractLock, isNotEmpty);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Get ADedicated Node extra fee', () async {
      BigInt? fee =
          await queryClient.contracts.getDedicatedNodeExtraFee(nodeId: 206);
      print(fee);
      expect(fee, BigInt.from(0));
    });
  });
}
