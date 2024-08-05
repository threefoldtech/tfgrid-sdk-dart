import 'package:test/test.dart';

import 'setup_manager.dart';

void main() {
  group("Price Tests", () {
    final setupManager = SetupManager();
    setUpAll(() async {
      setupManager.setInitializationFlags(queryClient: true);
      await setupManager.setup();
    });
    test('Test Get TFT price', () async {
      final price = await setupManager.queryClient.price.get();
      expect(price, isNotNull);
    });
  });
}
