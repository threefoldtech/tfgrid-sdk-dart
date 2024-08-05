import '../graphql_client.dart';
import '../models.dart';

class TFNodesResourcesTotals {
  final GraphQLClient gqlClient;

  TFNodesResourcesTotals(this.gqlClient);

  Future<List<NodeResourcesTotal>> nodeResourcesTotal(
      NodeResourcesTotalReturnOptions? returnOptions,
      NodeResourcesTotalQueryOptions? queryOptions) async {
    final queryString = queryOptions?.toString() ?? "";
    final returnString = returnOptions?.toString() ?? "id \n";
    final body = '''
query nodeResourcesTotals {
  nodeResourcesTotals $queryString {
    $returnString
  }
}''';
    final response = await gqlClient.query(body);

    if (response['data'] == null) throw Exception('Missing "data" field in response: $response');
    if (response['data']['nodeResourcesTotals'] == null) {
      throw Exception('Missing "nodeResourcesTotals" field in response data: ${response['data']}');
    }
    if (response['data']['nodeResourcesTotals'] is! List<dynamic>) {
      throw Exception('Invalid data format: Expected a list in "nodeResourcesTotals" field, got ${response['data']['nodeResourcesTotals'].runtimeType}');
    }
    List<NodeResourcesTotal> nodeResourcesTotals =
        (response['data']['nodeResourcesTotals'] as List<dynamic>)
            .map((nodeResourcesTotalsData) {
      return NodeResourcesTotal.fromJson(
          nodeResourcesTotalsData as Map<String, dynamic>);
    }).toList();
    return nodeResourcesTotals;
  }
}
