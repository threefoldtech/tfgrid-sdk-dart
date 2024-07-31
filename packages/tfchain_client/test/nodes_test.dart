import 'package:test/test.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_support/types/node.dart';
import 'package:tfchain_client/tfchain_client.dart';

import 'shared_setup.dart';

void main() {
  group("Test Query Nodes", () {
    late QueryClient queryClient;
    sharedSetup();

    setUp(() async {
      queryClient = QueryClient(url);
      await queryClient.connect();
    });

    test('Test get Node by Id', () async {
      Node? node = await queryClient.nodes.get(id: nodeId);
      expect(node, isNotNull);
    });

    test('Test get Node by wrong Id', () async {
      try {
        Node? node = await queryClient.nodes.get(id: invalidNodeId);
      } catch (error) {
        expect(error, isNotNull);
      }
    });

    tearDownAll(() async {
      await queryClient.disconnect();
    });
  });

  group("Test Nodes", () {
    late Client client;
    sharedSetup();

    setUp(() async {
      client = Client(url, mnemonic, type);
      await client.connect();
    });

    test('Test Set Power to node not owned by me', () async {
      try {
        await client.nodes.setPower(nodeId: nodeId, power: true);
      } catch (error) {
        expect(
          error,
          isNotNull,
        );
      }
    });

    test('Test Add public config to node not owned by me', () async {
      try {
        await client.nodes.addNodePublicConfig(
            farmId: farmId,
            nodeId: nodeId,
            ip4Ip: validIPv4,
            ip4Gw: gw4,
            domain: "");
      } catch (error) {
        expect(
          error,
          isNotNull,
        );
      }
    });

    tearDownAll(() async {
      await client.disconnect();
    });
  });
}
