import 'dart:io';

import 'package:test/test.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Price Test", () {
    late QueryClient queryClient;
    final String url =
        Platform.environment['URL'] ?? 'wss://tfchain.dev.grid.tf/ws';
    setUp(() async {
      queryClient = QueryClient(url);
      await queryClient.connect();
    });

    test('Test Get TFT price', () async {
      final price = await queryClient.price.get();
      expect(price, isNotNull);
    });

    tearDownAll(() async {
      await queryClient.disconnect();
    });
  });
}
