part of '../../models.dart';

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
    if (returnOptions != "") {
      returnOptions = "resourcesTotal { \n $returnOptions } \n";
    }
    return returnOptions;
  }
}

class NodeResourceTotal {
  String id;
  Node? node;
  BigInt? hru;
  BigInt? sru;
  BigInt? cru;
  BigInt? mru;

  NodeResourceTotal({
    required this.id,
    required this.node,
    required this.hru,
    required this.sru,
    required this.cru,
    required this.mru,
  });

  factory NodeResourceTotal.fromJson(Map<String, dynamic> json) {
    return NodeResourceTotal(
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
    return 'NodeResourceTotal(id: $id, node: $node, hru: $hru, sru: $sru, cru: $cru, mru: $mru)';
  }
}
