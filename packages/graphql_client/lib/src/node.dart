import '../graphql_client.dart';
import '../models.dart';

class TFNodes {
  final GraphQLClient gqlClient;

  TFNodes(this.gqlClient);

  Future<List<Node>> nodes(NodesReturnOptions? returnOptions,
      NodesQueryOptions? queryOptions) async {
    final queryString = queryOptions?.toString() ?? "";
    final returnString = returnOptions?.toString() ?? "id \n";
    final body = '''
query Nodes {
  nodes $queryString {
    $returnString
  }
}''';
    final response = await gqlClient.query(body);

    if (response['data'] == null) throw Exception('Missing "data" field');
    if (response['data']['nodes'] == null) {
      throw Exception('Missing "nodes" field');
    }
    if (response['data']['nodes'] is! List<dynamic>) {
      throw Exception('Invalid data format: Expected a list: $response');
    }
    List<Node> nodes =
        (response['data']['nodes'] as List<dynamic>).map((nodesData) {
      return Node.fromJson(nodesData as Map<String, dynamic>);
    }).toList();
    return nodes;
  }
}
