import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/farm.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Farms Test", () {
    late QueryClient queryClient;
    setUp(() {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
    });

    test('Test Get Farm by Id', () async {
      Farm? farm = await queryClient.farms.get(id: 1);
      expect(farm, isNotNull);
    });

    test('Test Get Farm by wrong Id', () async {
      try {
        Farm? farm = await queryClient.farms.get(id: -50);
        expect(farm, isNotNull);
      } catch (e) {
        expect(e, isNotNull);
      }
    });
  });
}
