import 'package:test/test.dart';

import 'shared_setup.dart';

void main() {
  group("Price Tests", () {
    sharedSetup();

    test('Test Get TFT price', () async {
      final price = await client.price.get();
      print(price);
      expect(price, isNotNull);
    });
  });
}
