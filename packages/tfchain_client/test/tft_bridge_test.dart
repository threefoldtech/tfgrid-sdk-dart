import 'dart:math';

import 'package:test/test.dart';

import 'globals.dart';
import 'setup_manager.dart';

void main() {
  group("Bridge Tests", () {
    late SetupManager setupManager;
    setUpAll(() async {
      setupManager = await getSetupManager();
    });
    test('Get Withdraw fee', () async {
      BigInt? fee = await setupManager.client.bridge.getWithdrawFee();
      expect(fee, isNotNull);
    });

    test('Get Deposit fee', () async {
      BigInt? fee = await setupManager.client.bridge.getDepositFee();
      expect(fee, isNotNull);
    });

    test('Swap to stellar zero TFTs', () async {
      try {
        await setupManager.client.bridge.swapToStellar(
            target: "GDHJP6TF3UXYXTNEZ2P36J5FH7W4BJJQ4AYYAXC66I2Q2AH5B6O6BCFG",
            amount: BigInt.zero);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Swap to stellar', () async {
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
