import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/node.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() {
  group("Test Query Nodes", () {
    late QueryClient queryClient;
    setUp(() async {
      queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
      await queryClient.connect();
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

  group("Test Nodes", () {
    late Client client;
    setUp(() async {
      client = Client(
          "wss://tfchain.dev.grid.tf/ws",
          "secret add bag cluster deposit beach illness letter crouch position rain arctic",
          "sr25519");
      await client.connect();
    });

    test('Test Set Power to node not owned by me', () async {
      try {
        await client.nodes.setPower(nodeId: 72, power: true);
      } catch (error) {
        expect(
          error.toString(),
          startsWith('Failed to apply extrinsic:'),
        );
      }
    });

    test('Test Add public config to node not owned by me', () async {
      try {
        await client.nodes.addNodePublicConfig(
            farmId: 1528,
            nodeId: 72,
            ip4Ip: "198.165.15.25/16",
            ip4Gw: "198.165.15.26",
            domain: "");
      } catch (error) {
        expect(
          error,
          isNotNull,
        );
      }
    });
  });
}
