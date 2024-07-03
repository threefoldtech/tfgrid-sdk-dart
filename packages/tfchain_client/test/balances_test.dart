import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/frame_system/account_info.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Balances Test", () {
    late QueryClient queryClient;
    setUp(() {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
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
      } catch (e) {
        expect(e, isNotNull);
      }
    });
  });
}
