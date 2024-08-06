part of '../models.dart';

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

@reflector
class GqlBaseContractReturnOptions {
  bool id;
  bool gridVersion;
  bool contractID;
  bool twinID;
  bool state;
  bool createdAt;
  bool solutionProviderID;

  GqlBaseContractReturnOptions({
    this.id = false,
    this.gridVersion = false,
    this.contractID = false,
    this.twinID = false,
    this.state = false,
    this.createdAt = false,
    this.solutionProviderID = false,
  });

  @override
  String toString() {
    String returnOptions = '';
    returnOptions = _addToReturnList(returnOptions, 'id', id);
    returnOptions = _addToReturnList(returnOptions, 'gridVersion', gridVersion);
    returnOptions = _addToReturnList(returnOptions, 'contractID', contractID);
    returnOptions = _addToReturnList(returnOptions, 'twinID', twinID);
    returnOptions = _addToReturnList(returnOptions, 'state', state);
    returnOptions = _addToReturnList(returnOptions, 'createdAt', createdAt);
    returnOptions = _addToReturnList(
        returnOptions, 'solutionProviderID', solutionProviderID);
    return returnOptions;
  }
}

class GqlBaseContract {
  String? id;
  int? gridVersion;
  String? contractID;
  int? twinID;
  String? state;
  String? createdAt;
  int? solutionProviderID;

  GqlBaseContract({
    this.id,
    this.gridVersion,
    this.contractID,
    this.twinID,
    this.state,
    this.createdAt,
    this.solutionProviderID,
  });
}

@reflector
class GqlNameContractReturnOptions extends GqlBaseContractReturnOptions {
  bool name;

  GqlNameContractReturnOptions({
    this.name = false,
    super.id = false,
    super.gridVersion = false,
    super.contractID = false,
    super.twinID = false,
    super.state = false,
    super.createdAt = false,
    super.solutionProviderID = false,
  });

  @override
  String toString() {
    String returnOptions = super.toString();
    returnOptions = _addToReturnList(returnOptions, 'name', name);
    return returnOptions;
  }
}

class GqlNameContract extends GqlBaseContract {
  String? name;

  GqlNameContract({
    super.id,
    super.gridVersion,
    super.contractID,
    super.twinID,
    super.state,
    super.createdAt,
    super.solutionProviderID,
    this.name,
  });

  factory GqlNameContract.fromJson(Map<String, dynamic> json) {
    return GqlNameContract(
      id: json['id'] ?? '',
      gridVersion: json['gridVersion'] ?? '',
      contractID: json['contractID'] ?? '',
      twinID: json['twinID'] ?? 0,
      state: json['state'] ?? '',
      createdAt: json['createdAt'] ?? '',
      solutionProviderID: json['solutionProviderID'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  @override
  String toString() {
    return 'GqlNameContract{id: $id, gridVersion: $gridVersion, contractID: $contractID, twinID: $twinID, state: $state, createdAt: $createdAt, solutionProviderID: $solutionProviderID, name: $name}';
  }
}

@reflector
class GqlNodeContractReturnOptions extends GqlBaseContractReturnOptions {
  bool nodeID;
  bool deploymentData;
  bool deploymentHash;
  bool numberOfPublicIPs;
  ContractUsedResourcesReturnOptions? resourcesUsed;

  GqlNodeContractReturnOptions({
    this.nodeID = false,
    this.deploymentData = false,
    this.deploymentHash = false,
    this.numberOfPublicIPs = false,
    this.resourcesUsed,
    super.id = false,
    super.gridVersion = false,
    super.contractID = false,
    super.twinID = false,
    super.state = false,
    super.createdAt = false,
    super.solutionProviderID = false,
  });

  @override
  String toString() {
    String returnOptions = super.toString();
    returnOptions = _addToReturnList(returnOptions, 'nodeID', nodeID);
    returnOptions =
        _addToReturnList(returnOptions, 'deploymentData', deploymentData);
    returnOptions =
        _addToReturnList(returnOptions, 'deploymentHash', deploymentHash);
    returnOptions =
        _addToReturnList(returnOptions, 'numberOfPublicIPs', numberOfPublicIPs);
    returnOptions = _addToReturnList(
        returnOptions, 'resourcesUsed{', resourcesUsed != null);
    returnOptions = _addToReturnList(
        returnOptions, resourcesUsed.toString(), resourcesUsed != null);
    returnOptions = _addToReturnList(returnOptions, '}', resourcesUsed != null);
    return returnOptions;
  }
}

class GqlNodeContract extends GqlBaseContract {
  int? nodeID;
  String? deploymentData;
  String? deploymentHash;
  int? numberOfPublicIPs;
  ContractUsedResources? resourcesUsed;

  GqlNodeContract({
    super.id,
    super.gridVersion,
    super.contractID,
    super.twinID,
    super.state,
    super.createdAt,
    super.solutionProviderID,
    this.nodeID,
    this.deploymentData,
    this.deploymentHash,
    this.numberOfPublicIPs,
    this.resourcesUsed,
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
      gridVersion: json['gridVersion'] ?? 0,
      id: json['id'] ?? '',
      resourcesUsed: json['resourcesUsed'] != null
          ? ContractUsedResources.fromJson(json['resourcesUsed'])
          : null,
    );
  }

  @override
  String toString() {
    return 'GqlNodeContract{id: $id, gridVersion: $gridVersion, contractID: $contractID, twinID: $twinID, state: $state, createdAt: $createdAt, solutionProviderID: $solutionProviderID, nodeID: $nodeID, deploymentData: $deploymentData, deploymentHash: $deploymentHash, numberOfPublicIPs: $numberOfPublicIPs, resourcesUsed: $resourcesUsed}';
  }
}

@reflector
class GqlRentContractReturnOptions extends GqlBaseContractReturnOptions {
  bool nodeID;

  GqlRentContractReturnOptions({
    this.nodeID = false,
    super.id = false,
    super.gridVersion = false,
    super.contractID = false,
    super.twinID = false,
    super.state = false,
    super.createdAt = false,
    super.solutionProviderID = false,
  });

  @override
  String toString() {
    String returnOptions = super.toString();
    returnOptions = _addToReturnList(returnOptions, 'nodeID', nodeID);
    return returnOptions;
  }
}

class GqlRentContract extends GqlBaseContract {
  int? nodeID;

  GqlRentContract({
    super.id,
    super.gridVersion,
    super.contractID,
    super.twinID,
    super.state,
    super.createdAt,
    super.solutionProviderID,
    this.nodeID,
  });

  factory GqlRentContract.fromJson(Map<String, dynamic> json) {
    return GqlRentContract(
      id: json['id'] ?? '',
      gridVersion: json['gridVersion'] ?? '',
      contractID: json['contractID'] ?? '',
      twinID: json['twinID'] ?? 0,
      state: json['state'] ?? '',
      createdAt: json['createdAt'] ?? '',
      solutionProviderID: json['solutionProviderID'] ?? 0,
      nodeID: json['nodeID'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'GqlRentContract{id: $id, gridVersion: $gridVersion, contractID: $contractID, twinID: $twinID, state: $state, createdAt: $createdAt, solutionProviderID: $solutionProviderID, nodeID: $nodeID}';
  }
}

@reflector
class ContractUsedResourcesReturnOptions {
  bool hru;
  bool sru;
  bool cru;
  bool mru;
  bool id;

  ContractUsedResourcesReturnOptions({
    this.hru = false,
    this.sru = false,
    this.cru = false,
    this.mru = false,
    this.id = false,
  });

  @override
  String toString() {
    String returnOptions = '';
    returnOptions = _addToReturnList(returnOptions, 'hru', hru);
    returnOptions = _addToReturnList(returnOptions, 'sru', sru);
    returnOptions = _addToReturnList(returnOptions, 'cru', cru);
    returnOptions = _addToReturnList(returnOptions, 'mru', mru);
    returnOptions = _addToReturnList(returnOptions, 'id', id);
    return returnOptions;
  }
}

class ContractUsedResources {
  String? hru;
  String? sru;
  String? cru;
  String? mru;
  String? id;

  ContractUsedResources({
    this.hru,
    this.sru,
    this.cru,
    this.mru,
    this.id,
  });

  factory ContractUsedResources.fromJson(Map<String, dynamic> json) {
    return ContractUsedResources(
      hru: json['hru'] ?? '',
      sru: json['sru'] ?? '',
      cru: json['cru'] ?? '',
      mru: json['mru'] ?? '',
      id: json['id'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ContractUsedResources{hru: $hru, sru: $sru, cru: $cru, mru: $mru, id: $id}';
  }
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
