// ignore_for_file: constant_identifier_names

part of '../models.dart';

class NodeEdgeInfo {
  String? cursor;
  Node? node;

  NodeEdgeInfo({
    this.cursor,
    this.node,
  });

  factory NodeEdgeInfo.fromJson(Map<String, dynamic> json) {
    return NodeEdgeInfo(
      cursor: json['cursor'] ?? '',
      node: json['node'] != null ? Node.fromJson(json['node']) : null,
    );
  }

  @override
  String toString() {
    return 'NodeEdgeInfo(cursor: $cursor, node: $node)';
  }
}

class NodeConnectionsInfo {
  List<NodeEdgeInfo>? edges;
  PageInfo? pageInfo;
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
          ? PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
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
  NodesOrderByOptions orderby;
  int? first;
  int? after;
  NodesQueryWhereOptions? whereOptions;

  NodesConnectionsQueryOptions({
    this.orderby = NodesOrderByOptions.id_ASC,
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
    return queryString.isNotEmpty ? "(${queryString.join(', ')})" : "";
  }
}

@reflector
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
    returnOptions = _addToReturnList(returnOptions, "cursor", cursor);
    returnOptions = _addToReturnList(returnOptions, "node {", node != null);
    returnOptions =
        _addToReturnList(returnOptions, node.toString(), node != null);
    returnOptions = _addToReturnList(returnOptions, "} ", node != null);
    if (returnOptions != "") returnOptions = "edges { \n $returnOptions } \n";
    return returnOptions;
  }
}

@reflector
class NodesConnectionsReturnOptions {
  NodeEdgeReturnOptions? edges;
  PageInfoReturnOptions? pageInfo;
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
    return returnOptions;
  }
}
