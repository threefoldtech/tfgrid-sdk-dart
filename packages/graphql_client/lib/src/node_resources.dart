import '../graphql_client.dart';
import '../models.dart';

const nodeResourcesNodeReturnOptions = '''
        node {
          certification
          city
          connectionPrice
          country
          created
          createdAt
          dedicated
          extraFee
          farmID
          farmingPolicyId
          gridVersion
          id
          nodeID
          secure
          serialNumber
          twinID
          updatedAt
          uptime
          virtualized
          publicConfig {
            domain
            gw4
            gw6
            id
            ipv4
            ipv6
          }
          power {
            state
            target
          }
          location {
            id
            latitude
            longitude
          }
          interfaces {
            ips
            id
            mac
            name
          }
        }
''';

class TFNodesResourcesTotals {
  final GraphQLClient gqlClient;

  TFNodesResourcesTotals(this.gqlClient);

  Future<List<NodeResourcesTotal>> nodeResourcesTotal(
      NodeResourcesTotalReturnOptions? returnOptions,
      NodeResourcesTotalQueryOptions? queryOptions) async {
    final queryString = queryOptions?.toString() ?? "";
    final String returnString;
    if (returnOptions == null || areAllBooleansFalse(returnOptions)) {
      returnString = '''
    cru
    hru
    id
    mru
    sru
    $nodeResourcesNodeReturnOptions
''';
    } else {
      returnString = returnOptions.toString();
    }
    final body = '''
query nodeResourcesTotals {
  nodeResourcesTotals $queryString {
    $returnString
  }
}''';
    final response = await gqlClient.query(body);
    if (response['data'] == null) {
      throw Exception('Missing "data" field in response: $response');
    }
    if (response['data']['nodeResourcesTotals'] == null) {
      throw Exception(
          'Missing "nodeResourcesTotals" field in response data: ${response['data']}');
    }
    if (response['data']['nodeResourcesTotals'] is! List<dynamic>) {
      throw Exception(
          'Invalid data format: Expected a list in "nodeResourcesTotals" field, got ${response['data']['nodeResourcesTotals'].runtimeType}');
    }
    List<NodeResourcesTotal> nodeResourcesTotals =
        (response['data']['nodeResourcesTotals'] as List<dynamic>)
            .map((nodeResourcesTotalsData) {
      return NodeResourcesTotal.fromJson(
          nodeResourcesTotalsData as Map<String, dynamic>);
    }).toList();
    return nodeResourcesTotals;
  }

  Future<NodeResourcesTotalsConnectionInfo> nodeResourcesTotalConnection(
      NodeResourcesTotalsConnectionReturnOptions? returnOptions,
      NodeResourcesTotalsConnectionQueryOptions? queryOptions) async {
    queryOptions ??= NodeResourcesTotalsConnectionQueryOptions();
    final queryString = queryOptions.toString();
    final String returnString;
    if (returnOptions == null || areAllBooleansFalse(returnOptions)) {
      returnString = '''
    edges {
      cursor
      node {
        cru
        hru
        mru
        id
        sru
        $nodeResourcesNodeReturnOptions
        }
      }
    totalCount
    pageInfo {
      endCursor
      hasNextPage
      hasPreviousPage
      startCursor
    }
''';
    } else {
      returnString = returnOptions.toString();
    }

    final body = '''
query Nodes {
  nodeResourcesTotalsConnection $queryString {
    $returnString
  }
}''';
    final response = await gqlClient.query(body);

    if (response['data'] == null) {
      throw Exception('Missing "data" field in response: $response');
    }
    if (response['data']['nodeResourcesTotalsConnection'] == null) {
      throw Exception(
          'Missing "nodeResourcesTotalsConnection" field in response data: ${response['data']}');
    }
    if (response['data']['nodeResourcesTotalsConnection']
        is! Map<String, dynamic>) {
      throw Exception(
          'Invalid data format: Expected a list of maps in "nodeResourcesTotalsConnection" field, got ${response['data']['nodeResourcesTotalsConnection'].runtimeType}');
    }
    NodeResourcesTotalsConnectionInfo nodeResourcesTotalsConnection =
        NodeResourcesTotalsConnectionInfo.fromJson(response['data']
            ['nodeResourcesTotalsConnection'] as Map<String, dynamic>);

    return nodeResourcesTotalsConnection;
  }
}
