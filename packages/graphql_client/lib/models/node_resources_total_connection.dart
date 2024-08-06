part of '../models.dart';

class NodeResourcesTotalEdgeInfo {
  String? cursor;
  NodeResourcesTotal? node;

  NodeResourcesTotalEdgeInfo({
    this.cursor,
    this.node,
  });

  factory NodeResourcesTotalEdgeInfo.fromJson(Map<String, dynamic> json) {
    return NodeResourcesTotalEdgeInfo(
      cursor: json['cursor'] ?? '',
      node: json['node'] != null
          ? NodeResourcesTotal.fromJson(json['node'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  String toString() {
    return 'NodeResourcesTotalEdgeInfo(cursor: $cursor, node: $node)';
  }
}

class NodeResourcesTotalsConnectionInfo {
  List<NodeResourcesTotalEdgeInfo>? edges;
  PageInfo? pageInfo;
  int? totalCount;

  NodeResourcesTotalsConnectionInfo({
    this.edges,
    this.pageInfo,
    this.totalCount,
  });

  factory NodeResourcesTotalsConnectionInfo.fromJson(
      Map<String, dynamic> json) {
    return NodeResourcesTotalsConnectionInfo(
      edges: json['edges'] != null
          ? (json['edges'] as List)
              .map((i) => NodeResourcesTotalEdgeInfo.fromJson(
                  i as Map<String, dynamic>))
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
    return 'NodeResourcesTotalsConnectionInfo(edges: $edges, pageInfo: $pageInfo, totalCount: $totalCount)';
  }
}

class NodeResourcesTotalsConnectionQueryOptions {
  NodeResourcesTotalOrderByOptions orderby;
  int? first;
  int? after;
  NodesQueryWhereOptions? whereOptions;

  NodeResourcesTotalsConnectionQueryOptions({
    this.orderby = NodeResourcesTotalOrderByOptions.id_ASC,
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
class NodeResourcesTotalEdgeReturnOptions {
  bool cursor;
  NodeResourcesTotalReturnOptions? node;

  NodeResourcesTotalEdgeReturnOptions({
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
class NodeResourcesTotalsConnectionReturnOptions {
  NodeResourcesTotalEdgeReturnOptions? edges;
  PageInfoReturnOptions? pageInfo;
  bool totalCount;

  NodeResourcesTotalsConnectionReturnOptions({
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
