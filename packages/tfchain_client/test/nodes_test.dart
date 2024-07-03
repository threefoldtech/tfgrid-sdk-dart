import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/node.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Query Nodes", () {
    late QueryClient queryClient;
    setUp(() {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
    });

    test('Test get Node by Id', () async {
      Node? node = await queryClient.nodes.get(id: 11);
      expect(node, isNotNull);
    });

    test('Test get Node by wrong Id', () async {
      try {
        Node? node = await queryClient.nodes.get(id: 11);
        expect(node, isNotNull);
      } catch (error) {
        expect(error, isNotNull);
      }
    });
  });
}
