import 'dart:io';

import 'package:test/test.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Bridge Test", () {
    late QueryClient queryClient;
    setUp(() async {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
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
  });

  group("Bridge Test", () {
    late Client client;
    final mnemonic = Platform.environment['MNEMONIC']!;
    final String link =
        Platform.environment['LINK'] ?? 'wss://tfchain.dev.grid.tf/ws';
    final String type = Platform.environment['SIGN_TYPE'] ?? 'sr25519';

    setUp(() async {
      client = Client(link, mnemonic, type);
      await client.connect();
    });

    test('Test swap to stellar zero TFTs', () async {
      try {
        await client.bridge.swapToStellar(
            target: "GDHJP6TF3UXYXTNEZ2P36J5FH7W4BJJQ4AYYAXC66I2Q2AH5B6O6BCFG",
            amount: 0);
      } catch (error) {
        expect(error, contains("AmountIsLessThanWithdrawFee"));
      }
    });

    test('Test swap to stellar', () async {
      try {
        await client.bridge.swapToStellar(
            target: "GDHJP6TF3UXYXTNEZ2P36J5FH7W4BJJQ4AYYAXC66I2Q2AH5B6O6BCFG",
            amount: 5);
      } catch (error) {
        expect(
          error,
          Null,
        );
      }
    });
  });
}
