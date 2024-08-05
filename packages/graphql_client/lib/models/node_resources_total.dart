part of '../models.dart';

enum NodeResourcesTotalOrderByOptions {
  none,
  id_ASC,
  id_DESC,
  node_id_ASC,
  node_id_DESC,
  node_gridVersion_ASC,
  node_gridVersion_DESC,
  node_nodeID_ASC,
  node_nodeID_DESC,
  node_farmID_ASC,
  node_farmID_DESC,
  node_twinID_ASC,
  node_twinID_DESC,
  node_country_ASC,
  node_country_DESC,
  node_city_ASC,
  node_city_DESC,
  node_uptime_ASC,
  node_uptime_DESC,
  node_created_ASC,
  node_created_DESC,
  node_farmingPolicyId_ASC,
  node_farmingPolicyId_DESC,
  node_certification_ASC,
  node_certification_DESC,
  node_secure_ASC,
  node_secure_DESC,
  node_virtualized_ASC,
  node_virtualized_DESC,
  node_serialNumber_ASC,
  node_serialNumber_DESC,
  node_createdAt_ASC,
  node_createdAt_DESC,
  node_updatedAt_ASC,
  node_updatedAt_DESC,
  node_connectionPrice_ASC,
  node_connectionPrice_DESC,
  node_dedicated_ASC,
  node_dedicated_DESC,
  node_extraFee_ASC,
  node_extraFee_DESC,
  hru_ASC,
  hru_DESC,
  sru_ASC,
  sru_DESC,
  cru_ASC,
  cru_DESC,
  mru_ASC,
  mru_DESC;

  String toString() {
    return this.name;
  }
}

class NodeResourcesTotalReturnOptions {
  bool id;
  bool cru;
  bool hru;
  bool mru;
  bool sru;
  NodesReturnOptions? node;

  NodeResourcesTotalReturnOptions({
    this.id = false,
    this.cru = false,
    this.hru = false,
    this.mru = false,
    this.sru = false,
    this.node,
  });
  @override
  String toString() {
    String returnOptions = "";
    if (!cru && !hru & !mru && !sru && !id && node == null) {
      node = NodesReturnOptions(id: true);
    }
    returnOptions = _addToReturnList(returnOptions, "id", id);
    returnOptions = _addToReturnList(returnOptions, "cru", cru);
    returnOptions = _addToReturnList(returnOptions, "hru", hru);
    returnOptions = _addToReturnList(returnOptions, "mru", mru);
    returnOptions = _addToReturnList(returnOptions, "sru", sru);
    returnOptions = _addToReturnList(returnOptions, "node {", node != null);
    returnOptions =
        _addToReturnList(returnOptions, node.toString(), node != null);
    returnOptions = _addToReturnList(returnOptions, "} ", node != null);
    return returnOptions;
  }
}

class NodeResourcesTotal {
  String id;
  Node? node;
  BigInt? hru;
  BigInt? sru;
  BigInt? cru;
  BigInt? mru;

  NodeResourcesTotal({
    required this.id,
    required this.node,
    required this.hru,
    required this.sru,
    required this.cru,
    required this.mru,
  });

  factory NodeResourcesTotal.fromJson(Map<String, dynamic> json) {
    return NodeResourcesTotal(
      id: json['id'] ?? "",
      node: json['node'] != null
          ? Node.fromJson(json['node'] as Map<String, dynamic>)
          : null,
      hru: json['hru'] != null ? BigInt.parse(json['hru']) : BigInt.zero,
      sru: json['sru'] != null ? BigInt.parse(json['sru']) : BigInt.zero,
      cru: json['cru'] != null ? BigInt.parse(json['cru']) : BigInt.zero,
      mru: json['mru'] != null ? BigInt.parse(json['mru']) : BigInt.zero,
    );
  }

  @override
  String toString() {
    return 'NodeResourcesTotal(id: $id, node: $node, hru: $hru, sru: $sru, cru: $cru, mru: $mru)';
  }
}

class NodeResourcesWhereOptions {
  //id
  bool? idIsNull;
  String? idEq;
  String? idNotEq;
  String? idGt;
  String? idGte;
  String? idLt;
  String? idLte;
  List<String>? idIn;
  List<String>? idNotIn;
  String? idContains;
  String? idNotContains;
  String? idContainsInsensitive;
  String? idNotContainsInsensitive;
  String? idStartsWith;
  String? idNotStartsWith;
  String? idEndsWith;
  String? idNotEndsWith;

  //node
  bool? nodeIsNull;
  NodesQueryWhereOptions? node;

  //hru
  bool? hruIsNull;
  BigInt? hruEq; //check
  BigInt? hruNotEq;
  BigInt? hruGt;
  BigInt? hruGte;
  BigInt? hruLt;
  BigInt? hruLte;
  List<BigInt>? hruIn;
  List<BigInt>? hruNotIn;

  //sru
  bool? sruIsNull;
  BigInt? sruEq;
  BigInt? sruNotEq;
  BigInt? sruGt;
  BigInt? sruGte;
  BigInt? sruLt;
  BigInt? sruLte;
  List<BigInt>? sruIn;
  List<BigInt>? sruNotIn;

  //cru
  bool? cruIsNull;
  BigInt? cruEq;
  BigInt? cruNotEq;
  BigInt? cruGt;
  BigInt? cruGte;
  BigInt? cruLt;
  BigInt? cruLte;
  List<BigInt>? cruIn;
  List<BigInt>? cruNotIn;

  //mru
  bool? mruIsNull;
  BigInt? mruEq;
  BigInt? mruNotEq;
  BigInt? mruGt;
  BigInt? mruGte;
  BigInt? mruLt;
  BigInt? mruLte;
  List<BigInt>? mruIn;
  List<BigInt>? mruNotIn;

  NodeResourcesWhereOptions({
    //id
    this.idIsNull,
    this.idEq,
    this.idNotEq,
    this.idGt,
    this.idGte,
    this.idLt,
    this.idLte,
    this.idIn,
    this.idNotIn,
    this.idContains,
    this.idNotContains,
    this.idContainsInsensitive,
    this.idNotContainsInsensitive,
    this.idStartsWith,
    this.idNotStartsWith,
    this.idEndsWith,
    this.idNotEndsWith,

    //node
    this.nodeIsNull,
    this.node,

    //hru
    this.hruIsNull,
    this.hruEq,
    this.hruNotEq,
    this.hruGt,
    this.hruGte,
    this.hruLt,
    this.hruLte,
    this.hruIn,
    this.hruNotIn,

    //sru
    this.sruIsNull,
    this.sruEq,
    this.sruNotEq,
    this.sruGt,
    this.sruGte,
    this.sruLt,
    this.sruLte,
    this.sruIn,
    this.sruNotIn,

    //cru
    this.cruIsNull,
    this.cruEq,
    this.cruNotEq,
    this.cruGt,
    this.cruGte,
    this.cruLt,
    this.cruLte,
    this.cruIn,
    this.cruNotIn,

    //mru
    this.mruIsNull,
    this.mruEq,
    this.mruNotEq,
    this.mruGt,
    this.mruGte,
    this.mruLt,
    this.mruLte,
    this.mruIn,
    this.mruNotIn,
  });

  @override
  String toString() {
    List<String> queryOptions = [];
    //id
    _addToQueryList(queryOptions, "id_isNull", idIsNull);
    _addToQueryList(queryOptions, "id_eq", idEq);
    _addToQueryList(queryOptions, "id_not_eq", idNotEq);
    _addToQueryList(queryOptions, "id_gt", idGt);
    _addToQueryList(queryOptions, "id_gte", idGte);
    _addToQueryList(queryOptions, "id_lt", idLt);
    _addToQueryList(queryOptions, "id_lte", idLte);
    _addToQueryList(queryOptions, "id_in", idIn);
    _addToQueryList(queryOptions, "id_not_in", idNotIn);
    _addToQueryList(queryOptions, "id_contains", idContains);
    _addToQueryList(queryOptions, "id_not_contains", idNotContains);
    _addToQueryList(
        queryOptions, "id_containsInsensitive", idContainsInsensitive);
    _addToQueryList(
        queryOptions, "id_not_containsInsensitive", idNotContainsInsensitive);
    _addToQueryList(queryOptions, "id_startsWith", idStartsWith);
    _addToQueryList(queryOptions, "id_not_startsWith", idNotStartsWith);
    _addToQueryList(queryOptions, "id_endsWith", idEndsWith);
    _addToQueryList(queryOptions, "id_not_endsWith", idNotEndsWith);

    //node
    _addToQueryList(queryOptions, "node_isNull", nodeIsNull);
    if (node != null) queryOptions.add('node: {${node.toString()}}');

    //hru
    _addToQueryList(queryOptions, "hru_isNull", hruIsNull);
    _addToQueryList(queryOptions, "hru_eq", hruEq);
    _addToQueryList(queryOptions, "hru_not_eq", hruNotEq);
    _addToQueryList(queryOptions, "hru_gt", hruGt);
    _addToQueryList(queryOptions, "hru_gte", hruGte);
    _addToQueryList(queryOptions, "hru_lt", hruLt);
    _addToQueryList(queryOptions, "hru_lte", hruLte);
    _addToQueryList(queryOptions, "hru_in", hruIn);
    _addToQueryList(queryOptions, "hru_not_in", hruNotIn);
    //sru
    _addToQueryList(queryOptions, "sru_isNull", sruIsNull);
    _addToQueryList(queryOptions, "sru_eq", sruEq);
    _addToQueryList(queryOptions, "sru_not_eq", sruNotEq);
    _addToQueryList(queryOptions, "sru_gt", sruGt);
    _addToQueryList(queryOptions, "sru_gte", sruGte);
    _addToQueryList(queryOptions, "sru_lt", sruLt);
    _addToQueryList(queryOptions, "sru_lte", sruLte);
    _addToQueryList(queryOptions, "sru_in", sruIn);
    _addToQueryList(queryOptions, "sru_not_in", sruNotIn);

    //cru
    _addToQueryList(queryOptions, "cru_isNull", cruIsNull);
    _addToQueryList(queryOptions, "cru_eq", cruEq);
    _addToQueryList(queryOptions, "cru_not_eq", cruNotEq);
    _addToQueryList(queryOptions, "cru_gt", cruGt);
    _addToQueryList(queryOptions, "cru_gte", cruGte);
    _addToQueryList(queryOptions, "cru_lt", cruLt);
    _addToQueryList(queryOptions, "cru_lte", cruLte);
    _addToQueryList(queryOptions, "cru_in", cruIn);
    _addToQueryList(queryOptions, "cru_not_in", cruNotIn);

    //mru
    _addToQueryList(queryOptions, "mru_isNull", mruIsNull);
    _addToQueryList(queryOptions, "mru_eq", mruEq);
    _addToQueryList(queryOptions, "mru_not_eq", mruNotEq);
    _addToQueryList(queryOptions, "mru_gt", mruGt);
    _addToQueryList(queryOptions, "mru_gte", mruGte);
    _addToQueryList(queryOptions, "mru_lt", mruLt);
    _addToQueryList(queryOptions, "mru_lte", mruLte);
    _addToQueryList(queryOptions, "mru_in", mruIn);
    _addToQueryList(queryOptions, "mru_not_in", mruNotIn);

    return queryOptions.isNotEmpty ? queryOptions.join(', ') : " ";
  }
}

class NodeResourcesTotalQueryOptions {
  NodeResourcesTotalOrderByOptions orderby;
  int? limit;
  int? offset;
  NodeResourcesWhereOptions? whereOptions;

  NodeResourcesTotalQueryOptions({
    this.orderby = NodeResourcesTotalOrderByOptions.none,
    this.limit,
    this.offset,
    this.whereOptions,
  });
  @override
  String toString() {
    String? order = orderby == NodeResourcesTotalOrderByOptions.none
        ? null
        : orderby.toString();
    if ((whereOptions != null && whereOptions.toString() == " ") &&
        order == null &&
        limit == null &&
        offset == null) return "";
    List<String> queryString = [];
    if (whereOptions != null && whereOptions.toString() != " ") {
      queryString.add("where: {${whereOptions.toString()}}");
    }
    if (order != null) queryString.add("orderBy: $order");
    if (limit != null) queryString.add("limit: $limit");
    if (offset != null) queryString.add("offset: $offset");
    return queryString.isEmpty ? "" : "(${queryString.join(', ')})";
  }
}
