import '../graphql_client.dart';
import '../models.dart';

const nodeReturnOptions = '''
certification
    city
    id
    gridVersion
    farmingPolicyId
    farmID
    dedicated
    createdAt
    extraFee
    created
    country
    connectionPrice
    nodeID
    secure
    serialNumber
    twinID
    updatedAt
    uptime
    virtualized
    resourcesTotal {
      cru
      hru
      id
      mru
      sru
    }
    publicConfig {
      domain
      gw4
      gw6
      ipv4
      id
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
    }''';

class TFNodes {
  final GraphQLClient gqlClient;

  TFNodes(this.gqlClient);

  Future<List<Node>> nodes(NodesReturnOptions? returnOptions,
      NodesQueryOptions? queryOptions) async {
    final queryString = queryOptions?.toString() ?? "";
    final String returnString;
    if (returnOptions == null || returnOptions.toString() == "") {
      returnString = nodeReturnOptions;
    } else {
      returnString = returnOptions.toString();
    }
    final body = '''
query Nodes {
  nodes $queryString {
    $returnString
  }
}''';
    final response = await gqlClient.query(body);

    if (response['data'] == null) {
      throw Exception('Missing "data" field in response: $response');
    }
    if (response['data']['nodes'] == null) {
      throw Exception(
          'Missing "nodes" field in response data: ${response['data']}');
    }
    if (response['data']['nodes'] is! List<dynamic>) {
      throw Exception(
          'Invalid data format: Expected a list in "nodes" field, got ${response['data']['nodes'].runtimeType}');
    }
    List<Node> nodes =
        (response['data']['nodes'] as List<dynamic>).map((nodesData) {
      return Node.fromJson(nodesData as Map<String, dynamic>);
    }).toList();
    return nodes;
  }

  Future<NodeConnectionsInfo> nodesConnection(
      NodesConnectionsReturnOptions? returnOptions,
      NodesConnectionsQueryOptions? queryOptions) async {
    queryOptions ??= NodesConnectionsQueryOptions();
    final queryString = queryOptions.toString();
    final String returnString;
    if (returnOptions == null || returnOptions.toString() == "") {
      returnString = '''
    pageInfo {
      endCursor
      hasNextPage
      hasPreviousPage
      startCursor
    }
    totalCount
    edges {
      cursor
      node {
        $nodeReturnOptions
      }
    }

''';
    } else {
      returnString = returnOptions.toString();
    }
    final body = '''
query Nodes {
  nodesConnection $queryString {
    $returnString
  }
}''';
    final response = await gqlClient.query(body);
    if (response['data'] == null) {
      throw Exception('Missing "data" field in response: $response');
    }
    if (response['data']['nodesConnection'] == null) {
      throw Exception(
          'Missing "nodesConnection" field in response data: ${response['data']}');
    }
    if (response['data']['nodesConnection'] is! Map<String, dynamic>) {
      throw Exception(
          'Invalid data format: Expected a list of maps in "nodesConnection" field, got ${response['data']['nodesConnection'].runtimeType}');
    }

    NodeConnectionsInfo nodesConnection = NodeConnectionsInfo.fromJson(
        response['data']['nodesConnection'] as Map<String, dynamic>);
    return nodesConnection;
  }
}
