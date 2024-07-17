import 'dart:io';

import 'package:test/test.dart';
import 'package:tfchain_client/tfchain_client.dart';

import 'shared_setup.dart';

void main() {
  group("Query Price Test", () {
    late QueryClient queryClient;
    sharedSetup();

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
