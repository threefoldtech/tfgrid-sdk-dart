import 'package:test/test.dart';

import 'globals.dart';
import 'setup_manager.dart';

void main() {
  group("Price Tests", () {
    late SetupManager setupManager;
    setUpAll(() async {
      setupManager = await getSetupManager();
    });
    test('Get TFT price', () async {
      final price = await setupManager.queryClient.price.get();
      expect(price, isNotNull);
    });
  });
}
