class StatsInfo {
  int accessNodes;
  int contracts;
  int countries;
  int dedicatedNodes;
  int farms;
  int gateways;
  int gpus;
  int nodes;
  Map<String, dynamic> nodesDistribution;
  int publicIps;
  int totalCru;
  int totalHru;
  int totalMru;
  int totalSru;
  int twins;
  int workloadsNumber;

  StatsInfo({
    required this.accessNodes,
    required this.contracts,
    required this.countries,
    required this.dedicatedNodes,
    required this.farms,
    required this.gateways,
    required this.gpus,
    required this.nodes,
    required this.nodesDistribution,
    required this.publicIps,
    required this.totalCru,
    required this.totalHru,
    required this.totalMru,
    required this.totalSru,
    required this.twins,
    required this.workloadsNumber,
  });

  factory StatsInfo.fromJson(Map<String, dynamic> json) {
    return StatsInfo(
      accessNodes: json['accessNodes'] ?? 0,
      contracts: json['contracts'] ?? 0,
      countries: json['countries'] ?? 0,
      dedicatedNodes: json['dedicatedNodes'] ?? 0,
      farms: json['farms'] ?? 0,
      gateways: json['gateways'] ?? 0,
      gpus: json['gpus'] ?? 0,
      nodes: json['nodes'] ?? 0,
      nodesDistribution: json['nodesDistribution'] ?? {},
      publicIps: json['publicIps'] ?? 0,
      totalCru: json['totalCru'] ?? '',
      totalHru: json['totalHru'] ?? 0,
      totalMru: json['totalMru'] ?? 0,
      totalSru: json['totalSru'] ?? 0,
      twins: json['twins'] ?? '',
      workloadsNumber: json['workloads_number'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessNodes': accessNodes,
      'contracts': contracts,
      'countries': countries,
      'dedicatedNodes': dedicatedNodes,
      'farms': farms,
      'gateways': gateways,
      'gpus': gpus,
      'nodes': nodes,
      'nodesDistribution': nodesDistribution.isEmpty ? '{}' : nodesDistribution,
      'publicIps': publicIps,
      'totalCru': totalCru,
      'totalHru': totalHru,
      'totalMru': totalMru,
      'totalSru': totalSru,
      'twins': twins,
      'workloads_number': workloadsNumber
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

enum NodeStatus {
  up,
  down,
  standby;

  @override
  String toString() {
    return name;
  }
}

class StatsQueryParams {
  NodeStatus? status;

  StatsQueryParams({
    this.status,
  });

  Map<String, dynamic> toMap() {
    final queryParameters = {
      if (status != null) 'status': status,
    };
    return queryParameters;
  }
}
