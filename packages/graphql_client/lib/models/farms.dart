class ListFarmsByTwinIdOptions {
  int twinId;

  ListFarmsByTwinIdOptions({
    required this.twinId,
  });
}

class FarmInfo {
  String? id;
  String? gridVersion;
  int farmID;
  String name;
  String certification;
  bool dedicatedFarm;
  int pricingPolicyID;
  String stellarAddress;
  int twinID;

  FarmInfo({
    this.id,
    this.gridVersion,
    required this.farmID,
    required this.name,
    required this.certification,
    required this.dedicatedFarm,
    required this.pricingPolicyID,
    required this.stellarAddress,
    required this.twinID,
  });
}
