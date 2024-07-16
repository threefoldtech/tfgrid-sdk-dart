import 'dart:io';

import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/contract.dart';
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/types/contract_lock.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Contracts Test", () {
    late QueryClient queryClient;
    setUp(() async {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
      await queryClient.connect();
    });

    tearDownAll(() async {
      await queryClient.disconnect();
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
      print(contracts);
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

    test('Test Get a Dedicated Node extra fee', () async {
      BigInt? fee =
          await queryClient.contracts.getDedicatedNodeExtraFee(nodeId: 140);
      print(fee);
      expect(fee, isNotNull);
    });
  });

  group("Test Contracts", () {
    late Client client;
    final mnemonic = Platform.environment['MNEMONIC']!;
    final String link =
        Platform.environment['LINK'] ?? 'wss://tfchain.dev.grid.tf/ws';
    final String type = Platform.environment['SIGN_TYPE'] ?? 'sr25519';

    setUp(() async {
      client = Client(link, mnemonic, type);
      await client.connect();
    });

    tearDownAll(() async {
      await client.disconnect();
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
        Contract? contract = await client.contracts
            .updateNode(contractId: 11, deploymentData: [], deploymentHash: []);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    // TODO: 
    // test('Test Create Name Contract then cancel it', () async {
    //   BigInt? contractId = await client.contracts.createName(name: "xxx");
    //   expect(contractId, isNotNull);
    //   await Future.delayed(Duration(seconds: 5));
    //   try {
    //     await client.contracts.cancel(contractId: contractId!);
    //   } catch (error) {
    //     expect(error, isNull);
    //   }
    // });

    test('Test Create Rent Contract with no solution provider', () async {
      try {
        BigInt? contractId = await client.contracts
            .createRent(nodeId: 72, solutionProviderId: 0);
      } catch (error) {
        expect(error.toString(), contains('NoSuchSolutionProvider'));
      }
    });

    test('Test set dedicated node extra fee', () async {
      BigInt? extraFee = await client.contracts
          .setDedicatedNodeExtraFee(nodeId: 140, extraFee: 2);
      expect(extraFee, BigInt.from(2));
    });
  });
}
