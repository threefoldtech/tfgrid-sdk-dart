part of '../../models.dart';

class PublicConfigReturnOptions {
  bool id;
  NodesReturnOptions? node;
  bool ipv4;
  bool ipv6;
  bool gw4;
  bool gw6;
  bool domain;

  PublicConfigReturnOptions({
    this.id = false,
    this.node,
    this.ipv4 = false,
    this.ipv6 = false,
    this.gw4 = false,
    this.gw6 = false,
    this.domain = false,
  });
  @override
  String toString() {
    String returnOptions = "";
    if (!ipv4 && !ipv6 & !gw4 && !gw6 && !domain && !id && node == null) {
      node = NodesReturnOptions(id: true);
    }
    returnOptions = _addToReturnList(returnOptions, "id", id);
    returnOptions = _addToReturnList(returnOptions, "ipv4", ipv4);
    returnOptions = _addToReturnList(returnOptions, "ipv6", ipv6);
    returnOptions = _addToReturnList(returnOptions, "gw4", gw4);
    returnOptions = _addToReturnList(returnOptions, "gw6", gw6);
    returnOptions = _addToReturnList(returnOptions, "domain", domain);
    returnOptions = _addToReturnList(returnOptions, "node {", node != null);
    returnOptions =
        _addToReturnList(returnOptions, node.toString(), node != null);
    returnOptions = _addToReturnList(returnOptions, "} ", node != null);
    if (returnOptions != "") {
      returnOptions = "publicConfig { \n $returnOptions } \n";
    }
    return returnOptions;
  }
}

class PublicConfig {
  String id;
  Node? node;
  String? ipv4;
  String? ipv6;
  String? gw4;
  String? gw6;
  String? domain;

  PublicConfig({
    required this.id,
    this.node,
    this.ipv4,
    this.ipv6,
    this.gw4,
    this.gw6,
    this.domain,
  });

  factory PublicConfig.fromJson(Map<String, dynamic> json) {
    return PublicConfig(
      id: json['id'] ?? "",
      node: json['node'] != null
          ? Node.fromJson(json['node'] as Map<String, dynamic>)
          : null,
      ipv4: json['ipv4'] ?? "",
      ipv6: json['ipv6'] ?? "",
      gw4: json['gw4'] ?? "",
      gw6: json['gw6'] ?? "",
      domain: json['domain'] ?? "",
    );
  }

  @override
  String toString() {
    return 'PublicConfig(id: $id, node: $node, ipv4: ${ipv4 ?? "N/A"}, ipv6: $ipv6, gw4: $gw4, gw6: $gw6, domain: $domain)';
  }
}
