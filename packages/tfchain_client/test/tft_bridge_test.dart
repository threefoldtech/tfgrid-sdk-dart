import 'dart:math';

import 'package:test/test.dart';

import 'globals.dart';

void main() {
  group("Bridge Tests", () {
    test('Test Get Withdraw fee', () async {
      BigInt? fee = await setupManager.client.bridge.getWithdrawFee();
      expect(fee, isNotNull);
    });

    test('Test Get Deposit fee', () async {
      BigInt? fee = await setupManager.client.bridge.getDepositFee();
      expect(fee, isNotNull);
    });

    test('Test swap to stellar zero TFTs', () async {
      try {
        await setupManager.client.bridge.swapToStellar(
            target: "GDHJP6TF3UXYXTNEZ2P36J5FH7W4BJJQ4AYYAXC66I2Q2AH5B6O6BCFG",
            amount: BigInt.zero);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Test swap to stellar', () async {
      try {
        var random = Random();
        var randomNumber = random.nextInt(100) + 1;
        await setupManager.client.bridge.swapToStellar(
            target: "GDHJP6TF3UXYXTNEZ2P36J5FH7W4BJJQ4AYYAXC66I2Q2AH5B6O6BCFG",
            amount: BigInt.from(randomNumber));
      } catch (error) {
        expect(
          error,
          Null,
        );
      }
    });
  });
}
