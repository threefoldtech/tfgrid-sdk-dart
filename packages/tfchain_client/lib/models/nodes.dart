class IPConfig {
  final String ip;
  final String gw;

  IPConfig({
    required this.ip,
    required this.gw,
  });
}

class PublicConfig {
  final IPConfig ip4;
  final IPConfig? ip6;
  final String? domain;

  PublicConfig({
    required this.ip4,
    this.ip6,
    this.domain,
  });
}

class NodePublicConfigOptions {
  final int farmId;
  final int nodeId;
  final PublicConfig publicConfig;

  NodePublicConfigOptions({
    required this.farmId,
    required this.nodeId,
    required this.publicConfig,
  });
}
