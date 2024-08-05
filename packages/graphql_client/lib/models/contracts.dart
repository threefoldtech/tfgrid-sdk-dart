enum DiscountLevel {
  None,
  Default,
  Bronze,
  Silver,
  Gold,
}

DiscountLevel parseDiscountLevel(String level) {
  switch (level.toLowerCase()) {
    case 'None':
      return DiscountLevel.None;
    case 'Default':
      return DiscountLevel.Default;
    case 'Bronze':
      return DiscountLevel.Bronze;
    case 'Silver':
      return DiscountLevel.Silver;
    case 'Gold':
      return DiscountLevel.Gold;
    default:
      return DiscountLevel.None;
  }
}

class GqlBaseContract {
  String? id;
  String? gridVersion;
  String contractID;
  int twinID;
  String state;
  String createdAt;
  int solutionProviderID;

  GqlBaseContract({
    this.id,
    this.gridVersion,
    required this.contractID,
    required this.twinID,
    required this.state,
    required this.createdAt,
    required this.solutionProviderID,
  });
}

class GqlNameContract extends GqlBaseContract {
  String name;

  GqlNameContract({
    super.id,
    super.gridVersion,
    required super.contractID,
    required super.twinID,
    required super.state,
    required super.createdAt,
    required super.solutionProviderID,
    required this.name,
  });

  factory GqlNameContract.fromJson(Map<String, dynamic> json) {
    return GqlNameContract(
        contractID: json['contractID'] ?? '',
        twinID: json['twinID'] ?? 0,
        state: json['state'] ?? '',
        createdAt: json['createdAt'] ?? '',
        solutionProviderID: json['solutionProviderID'] ?? 0,
        name: json['name'] ?? '');
  }
}

class GqlNodeContract extends GqlBaseContract {
  int nodeID;
  String deploymentData;
  String deploymentHash;
  int numberOfPublicIPs;
  ContractUsedResources? resourcesUsed;
  Map<String, String>? parsedDeploymentData;

  GqlNodeContract({
    super.id,
    super.gridVersion,
    required super.contractID,
    required super.twinID,
    required super.state,
    required super.createdAt,
    required super.solutionProviderID,
    required this.nodeID,
    required this.deploymentData,
    required this.deploymentHash,
    required this.numberOfPublicIPs,
    this.resourcesUsed,
    this.parsedDeploymentData,
  });

  factory GqlNodeContract.fromJson(Map<String, dynamic> json) {
    return GqlNodeContract(
      contractID: json['contractID'] ?? '',
      twinID: json['twinID'] ?? 0,
      state: json['state'] ?? '',
      createdAt: json['createdAt'] ?? '',
      solutionProviderID: json['solutionProviderID'] ?? 0,
      nodeID: json['nodeID'] ?? 0,
      deploymentData: json['deploymentData'] ?? '',
      deploymentHash: json['deploymentHash'] ?? '',
      numberOfPublicIPs: json['numberOfPublicIPs'] ?? 0,
    );
  }
}

class GqlRentContract extends GqlBaseContract {
  int nodeID;

  GqlRentContract({
    super.id,
    super.gridVersion,
    required super.contractID,
    required super.twinID,
    required super.state,
    required super.createdAt,
    required super.solutionProviderID,
    required this.nodeID,
  });

  factory GqlRentContract.fromJson(Map<String, dynamic> json) {
    return GqlRentContract(
      contractID: json['contractID'] ?? '',
      twinID: json['twinID'] ?? 0,
      state: json['state'] ?? '',
      createdAt: json['createdAt'] ?? '',
      solutionProviderID: json['solutionProviderID'] ?? 0,
      nodeID: json['nodeID'] ?? 0,
    );
  }
}

class ContractUsedResources {
  GqlNodeContract contract;
  int hru;
  int sru;
  int cru;
  int mru;

  ContractUsedResources({
    required this.contract,
    required this.hru,
    required this.sru,
    required this.cru,
    required this.mru,
  });
}

class GqlContracts {
  List<GqlNameContract> nameContracts;
  List<GqlNodeContract> nodeContracts;
  List<GqlRentContract> rentContracts;

  GqlContracts({
    required this.nameContracts,
    required this.nodeContracts,
    required this.rentContracts,
  });
}

class ListContractByTwinIdOptions {
  int twinId;
  List<String>? stateList;
  String? type;
  String? projectName;
  int? nodeId;

  ListContractByTwinIdOptions({
    required this.twinId,
    this.stateList,
    this.type,
    this.projectName,
    this.nodeId,
  });
}

class GetConsumptionOptions {
  String contractID;

  GetConsumptionOptions({
    required this.contractID,
  });
}

class GqlContractBillReports {
  String id;
  int contractID;
  DiscountLevel discountLevel;
  String amountBilled;
  String timeStamp;

  GqlContractBillReports({
    required this.id,
    required this.contractID,
    required this.discountLevel,
    required this.amountBilled,
    required this.timeStamp,
  });

  factory GqlContractBillReports.fromJson(Map<String, dynamic> json) {
    return GqlContractBillReports(
      id: json['id'] ?? '',
      contractID: json['contractID'] ?? 0,
      discountLevel: parseDiscountLevel(json['discountReceived']),
      amountBilled: json['amountBilled'] ?? '',
      timeStamp: json['timestamp'] ?? '',
    );
  }
}

class GqlConsumption {
  GqlContracts contracts;
  List<GqlContractBillReports> contractBillReports;

  GqlConsumption({
    required this.contracts,
    required this.contractBillReports,
  });
}
