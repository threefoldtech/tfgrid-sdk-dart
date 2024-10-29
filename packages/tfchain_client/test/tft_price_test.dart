import 'package:test/test.dart';

import 'globals.dart';

void main() {
  group("Price Tests", () {
    test('Test Get TFT price', () async {
      final price = await setupManager.queryClient.price.get();
      expect(price, isNotNull);
    });
  });
}
