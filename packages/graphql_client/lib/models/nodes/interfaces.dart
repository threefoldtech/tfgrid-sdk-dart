part of '../../models.dart';

class Interfaces {
  String id;
  Node? node;
  String? name;
  String? mac;
  String? ips;

  Interfaces({
    required this.id,
    this.node,
    this.name,
    this.mac,
    this.ips,
  });

  factory Interfaces.fromJson(Map<String, dynamic> json) {
    return Interfaces(
      id: json['id'] ?? "",
      node: json['node'] != null
          ? Node.fromJson(json['node'] as Map<String, dynamic>)
          : null,
      name: json['name'] ?? "",
      mac: json['mac'] ?? "",
      ips: json['ips'] ?? "",
    );
  }

  @override
  String toString() {
    return 'Interfaces(id: $id, node: $node, name: $name, mac: $mac, ips: $ips)';
  }
}

class InterfacesReturnOptions {
  bool id;
  NodesReturnOptions? node;
  bool name;
  bool mac;
  bool ips;

  InterfacesReturnOptions({
    this.id = false,
    this.node,
    this.name = false,
    this.mac = false,
    this.ips = false,
  });

  @override
  String toString() {
    String returnOptions = "";
    if (!name && !mac & !ips && !id && node == null) {
      node = NodesReturnOptions(id: true);
    }
    returnOptions = _addToReturnList(returnOptions, "id", id);
    returnOptions = _addToReturnList(returnOptions, "name", name);
    returnOptions = _addToReturnList(returnOptions, "mac", mac);
    returnOptions = _addToReturnList(returnOptions, "ips", ips);
    returnOptions = _addToReturnList(returnOptions, "node {", node != null);
    returnOptions =
        _addToReturnList(returnOptions, node.toString(), node != null);
    returnOptions = _addToReturnList(returnOptions, "} ", node != null);
    if (returnOptions != "") {
      returnOptions = "interfaces { \n $returnOptions } \n";
    }
    return returnOptions;
  }
}
