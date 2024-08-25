// ignore_for_file: constant_identifier_names
class Contract {}

class NameContract extends Contract {
  String name;

  NameContract({
    required this.name,
  });

  factory NameContract.fromJson(Map<String, dynamic> json) {
    return NameContract(
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name.isEmpty ? '""' : name,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class NodeContract extends Contract {
  int nodeID;
  String deploymentData;
  String deploymentHash;
  int numberOfPublicIps;
  String farmName;
  int farmID;

  NodeContract({
    required this.nodeID,
    required this.deploymentData,
    required this.deploymentHash,
    required this.numberOfPublicIps,
    required this.farmName,
    required this.farmID,
  });

  factory NodeContract.fromJson(Map<String, dynamic> json) {
    return NodeContract(
      nodeID: json['nodeId'] ?? 0,
      deploymentData: json['deployment_data'] ?? '',
      deploymentHash: json['deployment_hash'] ?? '',
      numberOfPublicIps: json['number_of_public_ips'] ?? 0,
      farmName: json['farm_name'] ?? '',
      farmID: json['farm_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nodeId': nodeID,
      'deployment_data': deploymentData.isEmpty ? '""' : deploymentData,
      'deployment_hash': deploymentHash.isEmpty ? '""' : deploymentHash,
      'number_of_public_ips': numberOfPublicIps,
      'farm_name': farmName.isEmpty ? '""' : farmName,
      'farm_id': farmID,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class RentContract extends Contract {
  int nodeID;
  String farmName;
  int farmID;

  RentContract(
      {required this.nodeID, required this.farmName, required this.farmID});

  factory RentContract.fromJson(Map<String, dynamic> json) {
    return RentContract(
      nodeID: json['nodeId'] ?? 0,
      farmName: json['farm_name'] ?? '',
      farmID: json['farm_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nodeId': nodeID,
      'farm_name': farmName.isEmpty ? '""' : farmName,
      'farm_id': farmID,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class ContractInfo {
  int contractID;
  int createdAt;
  Contract? details;
  String state;
  int twinID;
  String type;

  ContractInfo({
    required this.contractID,
    required this.createdAt,
    required this.details,
    required this.state,
    required this.twinID,
    required this.type,
  });

  factory ContractInfo.fromJson(Map<String, dynamic> json) {
    return ContractInfo(
      contractID: json['contract_id'] ?? 0,
      createdAt: json['created_at'] ?? 0,
      details: json['details'] != null
          ? json['details']['name'] != null
              ? NameContract.fromJson(json['details'] as Map<String, dynamic>)
              : json['details']['deployment_hash'] != null
                  ? NodeContract.fromJson(
                      json['details'] as Map<String, dynamic>)
                  : RentContract.fromJson(
                      json['details'] as Map<String, dynamic>)
          : null,
      state: json['state'] ?? '',
      twinID: json['twin_id'] ?? 0,
      type: json['type'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'contract_id': contractID,
      'twin_id': twinID,
      'state': state.isEmpty ? '""' : state,
      'created_at': createdAt,
      'type': type.isEmpty ? '""' : type,
      'details': details.toString(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
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

  Map<String, dynamic> toJson() {
    return {
      'amountBilled': amountBilled,
      if (contractID != 0) 'contract_id': contractID,
      'discountReceived': discountReceived.isEmpty ? '""' : discountReceived,
      'timestamp': timeStamp,
    };
  }

  @override
  String toString() {
    return toJson().toString();
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
