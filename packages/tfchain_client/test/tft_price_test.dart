import 'package:test/test.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Price Test", () {
    late QueryClient queryClient;
    setUp(() async {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
      await queryClient.connect();
    });

    test('Test Get TFT price', () async {
      final price = await queryClient.price.get();
      expect(price, isNotNull);
    });
  });
}
