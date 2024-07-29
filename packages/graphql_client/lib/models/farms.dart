class ListFarmsByTwinIdOptions {
  int twinId;

  ListFarmsByTwinIdOptions({
    required this.twinId,
  });
}

class FarmsReturnOptions {}

class FarmsQueryOptions {
  String? id_eq;
  String? id_gt;
  String? id_gte;

  FarmsQueryOptions({
    this.id_eq,
    this.id_gt,
    this.id_gte,
  });
}

FarmsQueryOptions queryOptionss = FarmsQueryOptions(id_eq: "10");
//queryOptionss.id_eq ?? string.append : nothing

class FarmInfo {
  String id;
  String? gridVersion;
  int? farmID;
  String? name;
  String? certification;
  bool? dedicatedFarm;
  int? pricingPolicyID;
  String? stellarAddress;
  int? twinID;

  FarmInfo({
    required this.id,
    this.gridVersion,
    this.farmID,
    this.name,
    this.certification,
    this.dedicatedFarm,
    this.pricingPolicyID,
    this.stellarAddress,
    this.twinID,
  });
}
