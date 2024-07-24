import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/frame_system/account_info.dart';
import 'package:tfchain_client/tfchain_client.dart';
import 'package:bip39/bip39.dart' as bip39;

import 'shared_setup.dart';

void main() {
  group("Balances Tests", () {
    sharedSetup();
    late final String recipientAddress;
    
    setUpAll(() async {
      final mnemonic = bip39.generateMnemonic();
      final recipientClient = Client(url, mnemonic, type);
      await recipientClient.connect();

      recipientAddress = recipientClient.address;
      Client alice = Client(url, "//Alice", type);
      await alice.connect();

      await alice.balances.transfer(address: client.address, amount: myBalance);
    });

    test('Test Get Balance', () async {
      AccountInfo? accountInfo = await client.balances.get(address: myAddress);
      expect(accountInfo, isNotNull);
    });

    test('Test Get Balance with Invalid address', () async {
      try {
        AccountInfo? accountInfo =
            await client.balances.get(address: "invalidAddress");
        expect(accountInfo, isNull);
      } catch (error) {
        expect(error, isNotNull);
      }
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
        AccountInfo? before =
            await client.balances.get(address: recipientAddress);
        await client.balances
            .transfer(address: recipientAddress, amount: BigInt.from(10));

        AccountInfo? after =
            await client.balances.get(address: recipientAddress);
        final diff = after!.data.free / BigInt.from(10).pow(7) -
            before!.data.free / BigInt.from(10).pow(7);
        print(diff);

        expect(diff, closeTo(10.0, 0.0001));
      } catch (error) {
        expect(error, isNull);
      }
    });

    test('Test get my balance', () async {
      AccountInfo? info = await client.balances.getMyBalance();
      expect(info, isNotNull);
    });
  });
}
