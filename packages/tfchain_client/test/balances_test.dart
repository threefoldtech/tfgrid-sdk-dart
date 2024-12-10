import 'dart:math';

import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/frame_system/account_info.dart';
import 'package:tfchain_client/tfchain_client.dart';
import 'package:bip39/bip39.dart' as bip39;

import 'globals.dart';
import 'setup_manager.dart';

void main() {
  group("Balances Tests", () {
    late SetupManager setupManager;
    late final String recipientAddress;
    late final Client alice;
    setUpAll(() async {
      setupManager = await getSetupManager();
      final mnemonic = bip39.generateMnemonic();
      final recipientClient =
          Client(setupManager.url, mnemonic, setupManager.type);
      await recipientClient.connect();

      recipientAddress = recipientClient.address;
      alice = Client(setupManager.url, "//Alice", setupManager.type);
      await alice.connect();

      await alice.balances.transfer(
          address: setupManager.client.address, amount: setupManager.myBalance);
    });

    test('Get balance', () async {
      AccountInfo? accountInfo = await setupManager.client.balances
          .get(address: setupManager.myAddress);
      expect(accountInfo, isNotNull);
    });

    test('Get balance with invalid address', () async {
      try {
        AccountInfo? accountInfo =
            await setupManager.client.balances.get(address: "invalidAddress");
        expect(accountInfo, isNull);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Transfer TFTs with invalid amount', () async {
      try {
        await setupManager.client.balances
            .transfer(address: recipientAddress, amount: 0);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    test('Transfer TFTs', () async {
      try {
        var random = Random();
        var randomNumber = random.nextInt(1000) + 1;
        AccountInfo? before =
            await setupManager.client.balances.get(address: recipientAddress);
        await setupManager.client.balances.transfer(
            address: recipientAddress, amount: randomNumber.toDouble());

        AccountInfo? after =
            await setupManager.client.balances.get(address: recipientAddress);
        final diff = after!.data.free / BigInt.from(10).pow(7) -
            before!.data.free / BigInt.from(10).pow(7);

        expect(diff, closeTo(randomNumber.toDouble(), 0.0001));
      } catch (error) {
        expect(error, isNull);
      }
    });

    test('Get my balance', () async {
      AccountInfo? info = await setupManager.client.balances.getMyBalance();
      expect(info, isNotNull);
    });
  });
}
