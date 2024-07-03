import 'package:test/test.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Bridge Test", () {
    late QueryClient queryClient;
    setUp(() {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
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
}
