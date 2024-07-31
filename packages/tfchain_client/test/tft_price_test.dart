import 'package:test/test.dart';

import 'setup_manager.dart';

void main() {
  group("Price Tests", () {
    final setupManager = SetupManager();
    setUpAll(() async {
      await setupManager.setup();
    });
    test('Test Get TFT price', () async {
      final price = await setupManager.client.price.get();
      print(price);
      expect(price, isNotNull);
    });
  });
}
