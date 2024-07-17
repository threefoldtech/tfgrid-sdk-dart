import 'dart:io';

import 'package:test/test.dart';
import 'package:tfchain_client/tfchain_client.dart';

import 'shared_setup.dart';

void main() {
  group("Query Bridge Test", () {
    late QueryClient queryClient;
    final String url =
        Platform.environment['URL'] ?? 'wss://tfchain.dev.grid.tf/ws';
    setUp(() async {
      queryClient = QueryClient(url);
      await queryClient.connect();
    });

    test('Test Get Withdraw fee', () async {
      BigInt? fee = await queryClient.bridge.getWithdrawFee();
      expect(fee, isNotNull);
    });

    test('Test Get Deposit fee', () async {
      BigInt? fee = await queryClient.bridge.getDepositFee();
      expect(fee, isNotNull);
    });

    tearDownAll(() async {
      await queryClient.disconnect();
    });
  });

  group("Bridge Test", () {
    late Client client;
    final mnemonic = Platform.environment['MNEMONIC']!;
    final String url =
        Platform.environment['URL'] ?? 'wss://tfchain.dev.grid.tf/ws';
    final String type = Platform.environment['KEYPAIR_TYPE'] ?? 'sr25519';
    sharedSetup();

    setUp(() async {
      client = Client(url, mnemonic, type);
      await client.connect();
    });

    test('Test swap to stellar zero TFTs', () async {
      try {
        await client.bridge
            .swapToStellar(target: stellarAddress, amount: BigInt.zero);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test swap to stellar', () async {
      try {
        await client.bridge
            .swapToStellar(target: stellarAddress, amount: BigInt.from(5));
      } catch (error) {
        expect(
          error,
          Null,
        );
      }
    });

    tearDownAll(() async {
      await client.disconnect();
    });
  });
}
