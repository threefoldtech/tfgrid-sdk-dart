// ignore_for_file: constant_identifier_names
class Details {}

class NameDetails extends Details {
  String name;

  NameDetails({required this.name});

  @override
  String toString() {
    return 'Details: {name: $name}';
  }

  factory NameDetails.fromJson(Map<String, dynamic> json) {
    return NameDetails(
      name: json['name'] ?? '',
    );
  }
}

class NodeDetails extends Details {
  int nodeID;
  String deploymentData;
  String deploymentHash;
  int numberOfPublicIps;
  String farmName;
  int farmId;

  NodeDetails(
      {required this.nodeID,
      required this.deploymentData,
      required this.deploymentHash,
      required this.numberOfPublicIps,
      required this.farmName,
      required this.farmId});

  factory NodeDetails.fromJson(Map<String, dynamic> json) {
    return NodeDetails(
      nodeID: json['nodeId'] ?? 0,
      deploymentData: json['deployment_data'] ?? '',
      deploymentHash: json['deployment_hash'] ?? '',
      numberOfPublicIps: json['number_of_public_ips'] ?? 0,
      farmName: json['farm_name'] ?? '',
      farmId: json['farm_id'] ?? 0,
    );
  }
  @override
  String toString() {
    return '''Details(nodeID: $nodeID, deploymentData: $deploymentData, deploymentHash: $deploymentHash, numberOfPublicIps: $numberOfPublicIps, farmName: $farmName, farmId: $farmId)''';
  }
}

class RentDetails extends Details {
  int nodeID;
  String farmName;
  int farmId;

  RentDetails(
      {required this.nodeID, required this.farmName, required this.farmId});

  factory RentDetails.fromJson(Map<String, dynamic> json) {
    return RentDetails(
      nodeID: json['nodeId'] ?? 0,
      farmName: json['farm_name'] ?? '',
      farmId: json['farm_id'] ?? 0,
    );
  }
  @override
  String toString() {
    return '''Details(nodeID: $nodeID, farmName: $farmName, farmId: $farmId)''';
  }
}

class ContractInfo {
  int contractId;
  int createdAt;
  Details? details;
  String state;
  int twinID;
  String type;

  ContractInfo({
    required this.contractId,
    required this.createdAt,
    required this.details,
    required this.state,
    required this.twinID,
    required this.type,
  });

  factory ContractInfo.fromJson(Map<String, dynamic> json) {
    return ContractInfo(
      contractId: json['contract_id'] ?? 0,
      createdAt: json['created_at'] ?? 0,
      details: json['details'] != null
          ? json['details']['name'] != null
              ? NameDetails.fromJson(json['details'] as Map<String, dynamic>)
              : json['details']['deployment_hash'] != null
                  ? NodeDetails.fromJson(
                      json['details'] as Map<String, dynamic>)
                  : RentDetails.fromJson(
                      json['details'] as Map<String, dynamic>)
          : null,
      state: json['state'] ?? '',
      twinID: json['twin_id'] ?? 0,
      type: json['type'] ?? '',
    );
  }
  @override
  String toString() {
    return '''Contract(contractId: $contractId, createdAt: $createdAt, details: $details, state: $state, twinID: $twinID, type: $type)''';
  }
}

enum ContractSortBy {
  twin_id,
  contract_id,
  type,
  state,
  created_at;

  @override
  String toString() {
    return name;
  }
}

enum ContractSortOrder {
  asc,
  desc;

  @override
  String toString() {
    return name;
  }
}

enum ContractTypes {
  node,
  name,
  rent;

  @override
  String toString() {
    return this.name;
  }
}

enum ContractState {
  Created,
  GracePeriod,
  Deleted;

  @override
  String toString() {
    return name;
  }
}

class ContractInfoQueryParams {
  int? page;
  int? size;
  bool? retCount;
  bool? randomize;
  ContractSortBy? sortBy;
  ContractSortOrder? sortOrder;
  int? contractId;
  int? twinID;
  int? nodeID;
  String? name;
  ContractTypes? type;
  ContractState? state;
  String? deploymentData;
  String? deploymentHash;
  int? numberOfPublicIps;

  ContractInfoQueryParams({
    this.page,
    this.size,
    this.retCount,
    this.randomize,
    this.sortBy,
    this.sortOrder,
    this.contractId,
    this.twinID,
    this.nodeID,
    this.name,
    this.type,
    this.state,
    this.deploymentData,
    this.deploymentHash,
    this.numberOfPublicIps,
  });

  Map<String, dynamic> toMap() {
    final queryParameters = {
      if (page != null) 'page': page,
      if (size != null) 'size': size,
      if (retCount != null) 'ret_count': retCount,
      if (randomize != null) 'randomize': randomize,
      if (sortBy != null) 'sort_by': sortBy,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (contractId != null) 'contract_id': contractId,
      if (twinID != null) 'twin_id': twinID,
      if (nodeID != null) 'node_id': nodeID,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (state != null) 'state': state,
      if (deploymentData != null) 'deployment_data': deploymentData,
      if (deploymentHash != null) 'deployment_hash': deploymentHash,
      if (numberOfPublicIps != null) 'number_of_public_ips': numberOfPublicIps,
    };
    return queryParameters;
  }
}

class ContractBills {
  int amountBilled;
  int contractID;
  String discountReceived;
  int timeStamp;

  ContractBills({
    required this.amountBilled,
    required this.contractID,
    required this.discountReceived,
    required this.timeStamp,
  });

  factory ContractBills.fromJson(Map<String, dynamic> json) {
    return ContractBills(
      amountBilled: json['amountBilled'] ?? 0,
      contractID: json['contract_id'] ?? 0,
      discountReceived: json['discountReceived'] ?? '',
      timeStamp: json['timestamp'] ?? 0,
    );
  }

  @override
  String toString() {
    return '''ContractBills(amountBilled: $amountBilled ,contractID: $contractID, discountReceived: $discountReceived, timeStamp: $timeStamp)''';
  }
}

class ContractBillQueryParams {
  int? page;
  int? size;
  bool? retCount;

  ContractBillQueryParams({
    this.page,
    this.size,
    this.retCount,
  });

  Map<String, dynamic> toMap() {
    final queryParameters = {
      if (page != null) 'page': page,
      if (size != null) 'size': size,
      if (retCount != null) 'ret_count': retCount,
    };
    return queryParameters;
  }
}
