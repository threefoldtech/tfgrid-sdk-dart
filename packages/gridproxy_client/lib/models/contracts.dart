import 'package:gridproxy_client/models/reflector.dart';
import 'package:gridproxy_client/src/query_builder.dart';

@reflector
class Contract {}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
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

@reflector
class ContractInfoQueryParams {
  int? page;
  int? size;
  bool? retCount;
  bool? randomize;
  ContractSortBy? sort_by;
  ContractSortOrder? sort_order;
  int? contract_id;
  int? twin_id;
  int? node_id;
  String? name;
  ContractTypes? type;
  ContractState? state;
  String? deployment_data;
  String? deployment_hash;
  int? number_of_public_ips;

  ContractInfoQueryParams({
    this.page,
    this.size,
    this.retCount,
    this.randomize,
    this.sort_by,
    this.sort_order,
    this.contract_id,
    this.twin_id,
    this.node_id,
    this.name,
    this.type,
    this.state,
    this.deployment_data,
    this.deployment_hash,
    this.number_of_public_ips,
  });

  Map<String, dynamic> toJson() {
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
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
    return toMap(this);
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

  Map<String, dynamic> toJson() {
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
