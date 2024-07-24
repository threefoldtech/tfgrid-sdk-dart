import 'package:test/test.dart';

import 'shared_setup.dart';

void main() {
  group("Bridge Tests", () {
    sharedSetup();

    test('Test Get Withdraw fee', () async {
      BigInt? fee = await client.bridge.getWithdrawFee();
      expect(fee, isNotNull);
    });

    test('Test Get Deposit fee', () async {
      BigInt? fee = await client.bridge.getDepositFee();
      expect(fee, isNotNull);
    });

    test('Test swap to stellar zero TFTs', () async {
      try {
        await client.bridge.swapToStellar(
            target: "GDHJP6TF3UXYXTNEZ2P36J5FH7W4BJJQ4AYYAXC66I2Q2AH5B6O6BCFG",
            amount: BigInt.zero);
      } catch (error) {
        expect(error, isNotNull);
      }
    });
  });

  // group("Bridge Test", () {
  //   sharedSetup();

  //   // test('Test swap to stellar', () async {
  //   //   try {
  //   //     await client.bridge
  //   //         .swapToStellar(target: stellarAddress, amount: BigInt.from(5));
  //   //   } catch (error) {
  //   //     expect(
  //   //       error,
  //   //       Null,
  //   //     );
  //   //   }
  //   // });

  //   // tearDownAll(() async {
  //   //   await client.disconnect();
  //   // });
  // });
}
