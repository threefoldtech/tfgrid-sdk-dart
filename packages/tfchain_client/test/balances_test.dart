import 'dart:io';

import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/frame_system/account_info.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Balances Test", () {
    late QueryClient queryClient;
    setUp(() async {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
      await queryClient.connect();
    });

    tearDown(() async {
      await queryClient.disconnect();
    });

    test('Test Get Balance', () async {
      String address = "5CJrCjZvsudNoJApTGG5PKcZfhAzAyGqgSK8bysoCV2oRBMC";
      AccountInfo? accountInfo =
          await queryClient.balances.get(address: address);
      expect(accountInfo, isNotNull);
    });

    test('Test Get Balance with Invalid address', () async {
      String address = "address";
      try {
        AccountInfo? accountInfo =
            await queryClient.balances.get(address: address);
        expect(accountInfo, isNull);
      } catch (error) {
        expect(error, isNotNull);
      }
    });
  });

  group("Test Balances", () {
    late Client client;
    final mnemonic = Platform.environment['MNEMONIC']!;
    final String link =
        Platform.environment['LINK'] ?? 'wss://tfchain.dev.grid.tf/ws';
    final String type = Platform.environment['SIGN_TYPE'] ?? 'sr25519';

    setUp(() async {
      client = Client(link, mnemonic, type);
      await client.connect();
    });

    tearDown(() async {
      await client.disconnect();
    });

    test('Test Transfer TFTs with invalid amount', () async {
      try {
        await client.balances.transfer(
            address:
                "oven strong mention shoulder night ghost correct exercise surge lady jungle hundred",
            amount: 0);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test Transfer TFTs', () async {
      try {
        await client.balances.transfer(
            address: "5EcSXeEH35LriE2aWxX6v4yZSMq47vdJ1GgHEXDdhJxg9XjG",
            amount: 10);
      } catch (error) {
        print(error);
        expect(error, isNull);
      }
    });

    test('Test get my balance', () async {
      AccountInfo? info = await client.balances.getMyBalance();
      expect(info, isNotNull);
    });
  });
}
