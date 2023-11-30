import 'package:tfchain_client/generated/dev/types/tfchain_support/types/node.dart';
import 'package:tfchain_client/tfchain_client.dart';

class QueryNodes {
  final QueryClient client;
  QueryNodes(this.client);

  Future<Node?> get({required int id}) async {
    if (id.isNaN || id <= 0) {
      throw Exception("Invalid node id. Node id must be a positive integer");
    }
    final res = await client.api.query.tfgridModule.nodes(id);
    return res as Node;
  }
}
