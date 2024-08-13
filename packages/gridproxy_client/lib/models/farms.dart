class ListFarmsQueryParameters {
  int? page;
  int? size;
  bool? retCount;
  bool? randomize;
  String? sortBy;
  String? sortOrder;
  int? freeIps;
  int? totalIps;
  int? pricingPolicyId;
  int? farmId;
  int? twinId;
  String? name;
  String? nameContains;
  String? certificationType;
  bool? dedicated;
  String? stellarAddress;
  int? nodeFreeMru;
  int? nodeFreeHru;
  int? nodeFreeSru;
  int? nodeTotalCru;
  String? nodeStatus;
  int? nodeRentedBy;
  int? nodeAvailableFor;
  bool? nodeHasGpu;
  bool? nodeHasIpv6;
  bool? nodeCertified;
  String? country;
  String? region;

  ListFarmsQueryParameters({
    this.page,
    this.size,
    this.retCount,
    this.randomize,
    this.sortBy,
    this.sortOrder,
    this.freeIps,
    this.totalIps,
    this.pricingPolicyId,
    this.farmId,
    this.twinId,
    this.name,
    this.nameContains,
    this.certificationType,
    this.dedicated,
    this.stellarAddress,
    this.nodeFreeMru,
    this.nodeFreeHru,
    this.nodeFreeSru,
    this.nodeTotalCru,
    this.nodeStatus,
    this.nodeRentedBy,
    this.nodeAvailableFor,
    this.nodeHasGpu,
    this.nodeHasIpv6,
    this.nodeCertified,
    this.country,
    this.region,
  });

  Map<String, String> toQueryParamaters() {
    final params = <String, String>{};

    if (page != null) params['page'] = page.toString();
    if (size != null) params['size'] = size.toString();
    if (retCount != null) params['ret_count'] = retCount.toString();
    if (randomize != null) params['randomize'] = randomize.toString();
    if (sortBy != null) params['sort_by'] = sortBy!;
    if (sortOrder != null) params['sort_order'] = sortOrder!;
    if (freeIps != null) params['free_ips'] = freeIps.toString();
    if (totalIps != null) params['total_ips'] = totalIps.toString();
    if (pricingPolicyId != null) {
      params['pricing_policy_id'] = pricingPolicyId.toString();
    }
    if (farmId != null) params['farm_id'] = farmId.toString();
    if (twinId != null) params['twin_id'] = twinId.toString();
    if (name != null) params['name'] = name!;
    if (nameContains != null) params['name_contains'] = nameContains!;
    if (certificationType != null) {
      params['certification_type'] = certificationType!;
    }
    if (dedicated != null) params['dedicated'] = dedicated.toString();
    if (stellarAddress != null) params['stellar_address'] = stellarAddress!;
    if (nodeFreeMru != null) params['node_free_mru'] = nodeFreeMru.toString();
    if (nodeFreeHru != null) params['node_free_hru'] = nodeFreeHru.toString();
    if (nodeFreeSru != null) params['node_free_sru'] = nodeFreeSru.toString();
    if (nodeTotalCru != null) {
      params['node_total_cru'] = nodeTotalCru.toString();
    }
    if (nodeStatus != null) params['node_status'] = nodeStatus!;
    if (nodeRentedBy != null) {
      params['node_rented_by'] = nodeRentedBy.toString();
    }
    if (nodeAvailableFor != null) {
      params['node_available_for'] = nodeAvailableFor.toString();
    }
    if (nodeHasGpu != null) params['node_has_gpu'] = nodeHasGpu.toString();
    if (nodeHasIpv6 != null) params['node_has_ipv6'] = nodeHasIpv6.toString();
    if (nodeCertified != null) {
      params['node_certified'] = nodeCertified.toString();
    }
    if (country != null) params['country'] = country!;
    if (region != null) params['region'] = region!;

    return params;
  }
}

class Farm {
  String? certificationType;
  bool? dedicated;
  int? farmId;
  String? name;
  int? pricingPolicyId;
  List<PublicIp>? publicIps;
  String? stellarAddress;
  int? twinId;

  Farm({
    this.certificationType,
    this.dedicated,
    this.farmId,
    this.name,
    this.pricingPolicyId,
    this.publicIps,
    this.stellarAddress,
    this.twinId,
  });

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      certificationType: json['certificationType'],
      dedicated: json['dedicated'],
      farmId: json['farmId'],
      name: json['name'],
      pricingPolicyId: json['pricingPolicyId'],
      publicIps: json['publicIps'] != null
          ? (json['publicIps'] as List)
              .map((i) => PublicIp.fromJson(i))
              .toList()
          : null,
      stellarAddress: json['stellarAddress'],
      twinId: json['twinId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (certificationType != null) {
      data['certificationType'] = certificationType;
    }
    if (dedicated != null) data['dedicated'] = dedicated;
    if (farmId != null) data['farmId'] = farmId;
    if (name != null) data['name'] = name;
    if (pricingPolicyId != null) data['pricingPolicyId'] = pricingPolicyId;
    if (publicIps != null) {
      data['publicIps'] = publicIps?.map((v) => v.toJson()).toList();
    }
    if (stellarAddress != null) data['stellarAddress'] = stellarAddress;
    if (twinId != null) data['twinId'] = twinId;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class PublicIp {
  int? contractId;
  String? farmId;
  String? gateway;
  String? id;
  String? ip;

  PublicIp({
    this.contractId,
    this.farmId,
    this.gateway,
    this.id,
    this.ip,
  });

  factory PublicIp.fromJson(Map<String, dynamic> json) {
    return PublicIp(
      contractId: json['contract_id'],
      farmId: json['farm_id'],
      gateway: json['gateway'],
      id: json['id'],
      ip: json['ip'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (contractId != null) data['contract_id'] = contractId;
    data['farm_id'] = farmId!.isEmpty ? '""' : farmId;
    if (gateway != null) data['gateway'] = gateway;
    if (id != null) data['id'] = id;
    if (ip != null) data['ip'] = ip;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
