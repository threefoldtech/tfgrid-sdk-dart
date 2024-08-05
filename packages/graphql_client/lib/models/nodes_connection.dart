part of '../models.dart';

//check lw bta3at node same
enum NodesConnectionOrderByOptions {
  none,
  id_ASC,
  id_DESC,
  gridVersion_ASC,
  gridVersion_DESC,
  nodeID_ASC,
  nodeID_DESC,
  farmID_ASC,
  farmID_DESC,
  NodeID_ASC,
  NodeID_DESC,
  location_id_ASC,
  location_id_DESC,
  location_longitude_ASC,
  location_longitude_DESC,
  location_latitude_ASC,
  location_latitude_DESC,
  country_ASC,
  country_DESC,
  city_ASC,
  city_DESC,
  publicConfig_id_ASC,
  publicConfig_id_DESC,
  publicConfig_ipv4_ASC,
  publicConfig_ipv4_DESC,
  publicConfig_ipv6_ASC,
  publicConfig_ipv6_DESC,
  publicConfig_gw4_ASC,
  publicConfig_gw4_DESC,
  publicConfig_gw6_ASC,
  publicConfig_gw6_DESC,
  publicConfig_domain_ASC,
  publicConfig_domain_DESC,
  resourcesTotal_id_ASC,
  resourcesTotal_id_DESC,
  resourcesTotal_hru_ASC,
  resourcesTotal_hru_DESC,
  resourcesTotal_sru_ASC,
  resourcesTotal_sru_DESC,
  resourcesTotal_cru_ASC,
  resourcesTotal_cru_DESC,
  resourcesTotal_mru_ASC,
  resourcesTotal_mru_DESC,
  uptime_ASC,
  uptime_DESC,
  created_ASC,
  created_DESC,
  farmingPolicyId_ASC,
  farmingPolicyId_DESC,
  certification_ASC,
  certification_DESC,
  secure_ASC,
  secure_DESC,
  virtualized_ASC,
  virtualized_DESC,
  serialNumber_ASC,
  serialNumber_DESC,
  createdAt_ASC,
  createdAt_DESC,
  updatedAt_ASC,
  updatedAt_DESC,
  connectionPrice_ASC,
  connectionPrice_DESC,
  power_state_ASC,
  power_state_DESC,
  power_target_ASC,
  power_target_DESC,
  dedicated_ASC,
  dedicated_DESC,
  extraFee_ASC,
  extraFee_DESC;

  @override
  String toString() {
    return this.name;
  }
}

class NodeEdgeInfo {
  String? cursor;
  Node node;

  NodeEdgeInfo({
    this.cursor,
    required this.node,
  });

  factory NodeEdgeInfo.fromJson(Map<String, dynamic> json) {
    return NodeEdgeInfo(
      cursor: json['cursor'] ?? '',
      node: Node.fromJson(json['node']),
    );
  }

  @override
  String toString() {
    return 'NodeConnectionEdgeInfo(cursor: $cursor, node: $node)';
  }
}

class NodeConnectionsInfo {
  List<NodeEdgeInfo>? edges;
  TwinConnectionsPageInfo? pageInfo; //fix odam bardo
  int? totalCount;

  NodeConnectionsInfo({
    this.edges,
    this.pageInfo,
    this.totalCount,
  });

  factory NodeConnectionsInfo.fromJson(Map<String, dynamic> json) {
    return NodeConnectionsInfo(
      edges: json['edges'] != null
          ? (json['edges'] as List)
              .map((i) => NodeEdgeInfo.fromJson(i as Map<String, dynamic>))
              .toList()
          : null,
      pageInfo: json['pageInfo'] != null
          ? TwinConnectionsPageInfo.fromJson(
              json['pageInfo'] as Map<String, dynamic>)
          : null,
      totalCount: json['totalCount'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'NodeConnectionsInfo(edges: $edges, pageInfo: $pageInfo, totalCount: $totalCount)';
  }
}

class NodesConnectionsQueryOptions {
  NodesConnectionOrderByOptions orderby;
  int? first;
  int? after;
  NodesQueryWhereOptions? whereOptions;

  NodesConnectionsQueryOptions({
    this.orderby = NodesConnectionOrderByOptions.id_ASC,
    this.first,
    this.after,
    this.whereOptions,
  });
  @override
  String toString() {
    List<String> queryString = [];
    if (whereOptions != null && whereOptions.toString() != " ") {
      queryString.add("where: {${whereOptions.toString()}}");
    }
    queryString.add("orderBy: $orderby");
    if (first != null) queryString.add("first: $first");
    if (after != null) queryString.add('after: "$after"');
    return "(${queryString.join(', ')})";
  }
}

class NodeEdgeReturnOptions {
  bool cursor;
  NodesReturnOptions? node;

  NodeEdgeReturnOptions({
    this.cursor = false,
    this.node,
  });

  @override
  String toString() {
    String returnOptions = "";
    if (!cursor && node == null) node = NodesReturnOptions(id: true);
    returnOptions = _addToReturnList(returnOptions, "cursor", cursor);
    returnOptions = _addToReturnList(returnOptions, "node {", node != null);
    returnOptions =
        _addToReturnList(returnOptions, node.toString(), node != null);
    returnOptions = _addToReturnList(returnOptions, "} ", node != null);
    if (returnOptions != "") returnOptions = "edges { \n $returnOptions } \n";
    return returnOptions;
  }
}

class NodesConnectionsReturnOptions {
  NodeEdgeReturnOptions? edges;
  TwinConnectionsPageReturnOptions? pageInfo; //Fix to be Page return info 3mtan
  bool totalCount;

  NodesConnectionsReturnOptions({
    this.edges,
    this.pageInfo,
    this.totalCount = false,
  });

  @override
  String toString() {
    String returnOptions = "";
    if (edges != null) returnOptions += edges.toString();
    if (pageInfo != null) returnOptions += pageInfo.toString();
    returnOptions = _addToReturnList(returnOptions, "totalCount", totalCount);
    if (returnOptions == "") {
      returnOptions = '''
      edges {
      node {
        id
      }
    }
''';
    }
    return returnOptions;
  }
}
