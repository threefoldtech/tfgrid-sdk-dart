import 'dart:io';

import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/frame_system/account_info.dart';
import 'package:tfchain_client/tfchain_client.dart';

import 'shared_setup.dart';

void main() {
  group("Query Balances Test", () {
    late QueryClient queryClient;
    sharedSetup();

    setUp(() async {
      queryClient = QueryClient(url);
      await queryClient.connect();
    });

    test('Test Get Balance', () async {
      AccountInfo? accountInfo =
          await queryClient.balances.get(address: myAddress);
      expect(accountInfo, isNotNull);
    });

    test('Test Get Balance with Invalid address', () async {
      try {
        AccountInfo? accountInfo =
            await queryClient.balances.get(address: invalidAddress);
        expect(accountInfo, isNull);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    tearDownAll(() async {
      await queryClient.disconnect();
    });
  });

  group("Test Balances", () {
    late Client client;
    sharedSetup();

    setUp(() async {
      client = Client(url, mnemonic, type);
      await client.connect();
    });

    test('Test Transfer TFTs with invalid amount', () async {
      try {
        await client.balances
            .transfer(address: recipientAddress, amount: BigInt.zero);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Transfer TFTs', () async {
      try {
        await client.balances
            .transfer(address: recipientAddress, amount: BigInt.from(10));
      } catch (error) {
        print(error);
        expect(error, isNull);
      }
    });

    test('Test get my balance', () async {
      AccountInfo? info = await client.balances.getMyBalance();
      expect(info, isNotNull);
    });

    tearDownAll(() async {
      await client.disconnect();
    });
  });
}
