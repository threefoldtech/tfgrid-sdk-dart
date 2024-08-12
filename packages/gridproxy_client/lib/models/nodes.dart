class GetNodeStatusOptions {
  int nodeID;

  GetNodeStatusOptions({
    required this.nodeID,
  });
}

class ListNodesQueryParamaters {
  int? page;
  int? size;
  bool? retCount;
  bool? randomize;
  String? sortBy;
  String? sortOrder;
  String? balance;
  int? freeMru;
  int? freeHru;
  int? freeSru;
  int? totalMru;
  int? totalCru;
  int? totalSru;
  int? totalHru;
  int? freeIps;
  String? status;
  bool? healthy;
  bool? hasIpv6;
  String? city;
  String? country;
  String? region;
  String? farmName;
  bool? ipv4;
  bool? ipv6;
  bool? domain;
  bool? dedicated;
  bool? inDedicatedFarm;
  bool? rentable;
  bool? rented;
  int? rentedBy;
  int? availableFor;
  String? farmIds;
  String? certificationType;
  bool? hasGpu;
  String? gpuDeviceId;
  String? gpuDeviceName;
  String? gpuVendorId;
  String? gpuVendorName;
  bool? gpuAvailable;
  int? ownedBy;
  String? priceMin;
  String? priceMax;

  ListNodesQueryParamaters({
    this.page,
    this.size,
    this.retCount,
    this.randomize,
    this.sortBy,
    this.sortOrder,
    this.balance,
    this.freeMru,
    this.freeHru,
    this.freeSru,
    this.totalMru,
    this.totalCru,
    this.totalSru,
    this.totalHru,
    this.freeIps,
    this.status,
    this.healthy,
    this.hasIpv6,
    this.city,
    this.country,
    this.region,
    this.farmName,
    this.ipv4,
    this.ipv6,
    this.domain,
    this.dedicated,
    this.inDedicatedFarm,
    this.rentable,
    this.rented,
    this.rentedBy,
    this.availableFor,
    this.farmIds,
    this.certificationType,
    this.hasGpu,
    this.gpuDeviceId,
    this.gpuDeviceName,
    this.gpuVendorId,
    this.gpuVendorName,
    this.gpuAvailable,
    this.ownedBy,
    this.priceMin,
    this.priceMax,
  });

  Map<String, String> toQueryParamaters() {
    final params = <String, String>{};

    if (page != null) params['page'] = page.toString();
    if (size != null) params['size'] = size.toString();
    if (retCount != null) params['ret_count'] = retCount.toString();
    if (randomize != null) params['randomize'] = randomize.toString();
    if (sortBy != null) params['sort_by'] = sortBy!;
    if (sortOrder != null) params['sort_order'] = sortOrder!;
    if (balance != null) params['balance'] = balance!;
    if (freeMru != null) params['free_mru'] = freeMru.toString();
    if (freeHru != null) params['free_hru'] = freeHru.toString();
    if (freeSru != null) params['free_sru'] = freeSru.toString();
    if (totalMru != null) params['total_mru'] = totalMru.toString();
    if (totalCru != null) params['total_cru'] = totalCru.toString();
    if (totalSru != null) params['total_sru'] = totalSru.toString();
    if (totalHru != null) params['total_hru'] = totalHru.toString();
    if (freeIps != null) params['free_ips'] = freeIps.toString();
    if (status != null) params['status'] = status!;
    if (healthy != null) params['healthy'] = healthy.toString();
    if (hasIpv6 != null) params['has_ipv6'] = hasIpv6.toString();
    if (city != null) params['city'] = city!;
    if (country != null) params['country'] = country!;
    if (region != null) params['region'] = region!;
    if (farmName != null) params['farm_name'] = farmName!;
    if (ipv4 != null) params['ipv4'] = ipv4.toString();
    if (ipv6 != null) params['ipv6'] = ipv6.toString();
    if (domain != null) params['domain'] = domain.toString();
    if (dedicated != null) params['dedicated'] = dedicated.toString();
    if (inDedicatedFarm != null) {
      params['in_dedicated_farm'] = inDedicatedFarm.toString();
    }
    if (rentable != null) params['rentable'] = rentable.toString();
    if (rented != null) params['rented'] = rented.toString();
    if (rentedBy != null) params['rented_by'] = rentedBy.toString();
    if (availableFor != null) params['available_for'] = availableFor.toString();
    if (farmIds != null) params['farm_ids'] = farmIds!;
    if (certificationType != null) {
      params['certification_type'] = certificationType!;
    }
    if (hasGpu != null) params['has_gpu'] = hasGpu.toString();
    if (gpuDeviceId != null) params['gpu_device_id'] = gpuDeviceId!;
    if (gpuDeviceName != null) params['gpu_device_name'] = gpuDeviceName!;
    if (gpuVendorId != null) params['gpu_vendor_id'] = gpuVendorId!;
    if (gpuVendorName != null) params['gpu_vendor_name'] = gpuVendorName!;
    if (gpuAvailable != null) params['gpu_available'] = gpuAvailable.toString();
    if (ownedBy != null) params['owned_by'] = ownedBy.toString();
    if (priceMin != null) params['price_min'] = priceMin!;
    if (priceMax != null) params['price_max'] = priceMax!;

    return params;
  }
}

class Node {
  String? certificationType;
  String? city;
  String? country;
  int? created;
  bool? dedicated;
  Dmi? dmi;
  int? extraFee;
  int? farmId;
  String? farmName;
  int? farmingPolicyId;
  int? gridVersion;
  bool? healthy;
  String? id;
  bool? inDedicatedFarm;
  Location? location;
  int? nodeId;
  int? numGpu;
  Power? power;
  double? priceUsd;
  PublicConfig? publicConfig;
  int? rentContractId;
  bool? rentable;
  bool? rented;
  int? rentedByTwinId;
  String? serialNumber;
  Speed? speed;
  String? status;
  Resources? totalResources;
  int? twinId;
  int? updatedAt;
  int? uptime;
  Resources? usedResources;

  Node({
    this.certificationType,
    this.city,
    this.country,
    this.created,
    this.dedicated,
    this.dmi,
    this.extraFee,
    this.farmId,
    this.farmName,
    this.farmingPolicyId,
    this.gridVersion,
    this.healthy,
    this.id,
    this.inDedicatedFarm,
    this.location,
    this.nodeId,
    this.numGpu,
    this.power,
    this.priceUsd,
    this.publicConfig,
    this.rentContractId,
    this.rentable,
    this.rented,
    this.rentedByTwinId,
    this.serialNumber,
    this.speed,
    this.status,
    this.totalResources,
    this.twinId,
    this.updatedAt,
    this.uptime,
    this.usedResources,
  });

  factory Node.fromJson(Map<String, dynamic> json) {
    final capacity = json['capacity'];
    return Node(
      certificationType: json['certificationType'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      created: json['created'] ?? 0,
      dedicated: json['dedicated'] ?? false,
      dmi: json['dmi'] != null ? Dmi.fromJson(json['dmi']) : null,
      extraFee: json['extraFee'] ?? 0,
      farmId: json['farmId'] ?? 0,
      farmName: json['farmName'] ?? '',
      farmingPolicyId: json['farmingPolicyId'] ?? 0,
      gridVersion: json['gridVersion'] ?? 0,
      healthy: json['healthy'] ?? false,
      id: json['id'] ?? '',
      inDedicatedFarm: json['inDedicatedFarm'] ?? false,
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      nodeId: json['nodeId'] ?? 0,
      numGpu: json['num_gpu'] ?? 0,
      power: json['power'] != null ? Power.fromJson(json['power']) : null,
      priceUsd: json['price_usd'].toDouble() ?? 0,
      publicConfig: json['publicConfig'] != null
          ? PublicConfig.fromJson(json['publicConfig'])
          : null,
      rentContractId: json['rentContractId'] ?? 0,
      rentable: json['rentable'] ?? false,
      rented: json['rented'] ?? false,
      rentedByTwinId: json['rentedByTwinId'] ?? 0,
      serialNumber: json['serialNumber'] ?? '',
      speed: json['speed'] != null ? Speed.fromJson(json['speed']) : null,
      status: json['status'] ?? '',
      twinId: json['twinId'] ?? 0,
      updatedAt: json['updatedAt'] ?? 0,
      uptime: json['uptime'] ?? 0,
      usedResources: capacity != null && capacity['used_resources'] != null
          ? Resources.fromJson(capacity['used_resources'])
          : json['used_resources'] != null
              ? Resources.fromJson(json['used_resources'])
              : null,
      totalResources: capacity != null && capacity['total_resources'] != null
          ? Resources.fromJson(capacity['total_resources'])
          : json['total_resources'] != null
              ? Resources.fromJson(json['total_resources'])
              : null,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (certificationType != null) {
      data['certificationType'] = certificationType;
    }
    if (city != null) data['city'] = city;
    if (country != null) data['country'] = country;
    if (created != null) data['created'] = created;
    if (dedicated != null) data['dedicated'] = dedicated;
    if (dmi != null) data['dmi'] = dmi?.toJson();
    if (extraFee != null) data['extraFee'] = extraFee;
    if (farmId != null) data['farmId'] = farmId;
    if (farmName != null) data['farmName'] = farmName;
    if (farmingPolicyId != null) data['farmingPolicyId'] = farmingPolicyId;
    if (gridVersion != null) data['gridVersion'] = gridVersion;
    if (healthy != null) data['healthy'] = healthy;
    if (id != null) data['id'] = id;
    if (inDedicatedFarm != null) data['inDedicatedFarm'] = inDedicatedFarm;
    if (location != null) data['location'] = location?.toJson();
    if (nodeId != null) data['nodeId'] = nodeId;
    if (numGpu != null) data['num_gpu'] = numGpu;
    if (power != null) data['power'] = power?.toJson();
    if (priceUsd != null) data['price_usd'] = priceUsd;
    if (publicConfig != null) data['publicConfig'] = publicConfig?.toJson();
    if (rentContractId != null) data['rentContractId'] = rentContractId;
    if (rentable != null) data['rentable'] = rentable;
    if (rented != null) data['rented'] = rented;
    if (rentedByTwinId != null) data['rentedByTwinId'] = rentedByTwinId;
    if (serialNumber != null) data['serialNumber'] = serialNumber;
    if (speed != null) data['speed'] = speed?.toJson();
    if (status != null) data['status'] = status;
    if (totalResources != null) {
      data['total_resources'] = totalResources?.toJson();
    }
    if (twinId != null) data['twinId'] = twinId;
    if (updatedAt != null) data['updatedAt'] = updatedAt;
    if (uptime != null) data['uptime'] = uptime;
    if (usedResources != null) data['used_resources'] = usedResources?.toJson();

    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Dmi {
  Baseboard? baseboard;
  Bios? bios;
  List<Memory>? memory;
  int? nodeTwinId;
  List<Processor>? processor;

  Dmi({
    this.baseboard,
    this.bios,
    this.memory,
    this.nodeTwinId,
    this.processor,
  });

  factory Dmi.fromJson(Map<String, dynamic> json) {
    return Dmi(
      baseboard: json['baseboard'] != null
          ? Baseboard.fromJson(json['baseboard'])
          : null,
      bios: json['bios'] != null ? Bios.fromJson(json['bios']) : null,
      memory: json['memory'] != null
          ? (json['memory'] as List).map((i) => Memory.fromJson(i)).toList()
          : [],
      nodeTwinId: json['node_twin_id'] ?? 0,
      processor: json['processor'] != null
          ? (json['processor'] as List)
              .map((i) => Processor.fromJson(i))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (baseboard != null) data['baseboard'] = baseboard!.toJson();
    if (bios != null) data['bios'] = bios!.toJson();
    if (memory != null) {
      data['memory'] = memory!.map((v) => v.toJson()).toList();
    }
    if (nodeTwinId != null) data['node_twin_id'] = nodeTwinId;
    if (processor != null) {
      data['processor'] = processor!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Bios {
  String? vendor;
  String? version;

  Bios({
    this.vendor,
    this.version,
  });

  factory Bios.fromJson(Map<String, dynamic> json) {
    return Bios(
      vendor: json['vendor'] ?? '',
      version: json['version'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (vendor != null) data['vendor'] = vendor;
    if (version != null) data['version'] = version;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Memory {
  String? manufacturer;
  String? type;

  Memory({
    this.manufacturer,
    this.type,
  });

  factory Memory.fromJson(Map<String, dynamic> json) {
    return Memory(
      manufacturer: json['manufacturer'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (manufacturer != null) data['manufacturer'] = manufacturer;
    if (type != null) data['type'] = type;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Processor {
  String? threadCount;
  String? version;

  Processor({
    this.threadCount,
    this.version,
  });

  factory Processor.fromJson(Map<String, dynamic> json) {
    return Processor(
      threadCount: json['thread_count'] ?? '',
      version: json['version'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (threadCount != null) data['thread_count'] = threadCount;
    if (version != null) data['version'] = version;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Location {
  String? city;
  String? country;
  double? latitude;
  double? longitude;

  Location({
    this.city,
    this.country,
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (city != null) data['city'] = city;
    if (country != null) data['country'] = country;
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Power {
  String? state;
  String? target;

  Power({
    this.state,
    this.target,
  });

  factory Power.fromJson(Map<String, dynamic> json) {
    return Power(
      state: json['state'] ?? '',
      target: json['target'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (state != null) data['state'] = state;
    if (target != null) data['target'] = target;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class PublicConfig {
  String? domain;
  String? gw4;
  String? gw6;
  String? ipv4;
  String? ipv6;

  PublicConfig({
    this.domain,
    this.gw4,
    this.gw6,
    this.ipv4,
    this.ipv6,
  });

  factory PublicConfig.fromJson(Map<String, dynamic> json) {
    return PublicConfig(
      domain: json['domain'] ?? '',
      gw4: json['gw4'] ?? '',
      gw6: json['gw6'] ?? '',
      ipv4: json['ipv4'] ?? '',
      ipv6: json['ipv6'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (domain != null) data['domain'] = domain;
    if (gw4 != null) data['gw4'] = gw4;
    if (gw6 != null) data['gw6'] = gw6;
    if (ipv4 != null) data['ipv4'] = ipv4;
    if (ipv6 != null) data['ipv6'] = ipv6;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Speed {
  double? download;
  int? nodeTwinId;
  double? upload;

  Speed({
    this.download,
    this.nodeTwinId,
    this.upload,
  });

  factory Speed.fromJson(Map<String, dynamic> json) {
    return Speed(
      download: json['download'].toDouble() ?? 0.0,
      nodeTwinId: json['node_twin_id'] ?? 0,
      upload: json['upload'].toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (download != null) data['download'] = download;
    if (nodeTwinId != null) data['node_twin_id'] = nodeTwinId;
    if (upload != null) data['upload'] = upload;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Baseboard {
  String? manufacturer;
  String? productName;

  Baseboard({
    this.manufacturer,
    this.productName,
  });

  factory Baseboard.fromJson(Map<String, dynamic> json) {
    return Baseboard(
      manufacturer: json['manufacturer'] ?? '',
      productName: json['product_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (manufacturer != null) data['manufacturer'] = manufacturer;
    if (productName != null) data['product_name'] = productName;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Resources {
  int? cru;
  int? hru;
  int? mru;
  int? sru;
  int? ipv4u;

  Resources({
    this.cru,
    this.hru,
    this.mru,
    this.sru,
    this.ipv4u,
  });

  factory Resources.fromJson(Map<String, dynamic> json) {
    return Resources(
      cru: json['cru'] ?? 0,
      hru: json['hru'] ?? 0,
      mru: json['mru'] ?? 0,
      sru: json['sru'] ?? 0,
      ipv4u: json['ipv4u'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (cru != null) data['cru'] = cru;
    if (hru != null) data['hru'] = hru;
    if (mru != null) data['mru'] = mru;
    if (sru != null) data['sru'] = sru;
    if (ipv4u != null) data['ipv4u'] = ipv4u;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class NodeGPUInfo {
  int? contract;
  String? device;
  String? id;
  int? nodeTwinId;
  int? updatedAt;
  String? vendor;

  NodeGPUInfo({
    this.contract,
    this.device,
    this.id,
    this.nodeTwinId,
    this.updatedAt,
    this.vendor,
  });

  factory NodeGPUInfo.fromJson(Map<String, dynamic> json) {
    return NodeGPUInfo(
      contract: json['contract'],
      device: json['device'],
      id: json['id'],
      nodeTwinId: json['node_twin_id'],
      updatedAt: json['updated_at'],
      vendor: json['vendor'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (contract != null) data['contract'] = contract;
    if (device != null) data['device'] = device;
    if (id != null) data['id'] = id;
    if (nodeTwinId != null) data['node_twin_id'] = nodeTwinId;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (vendor != null) data['vendor'] = vendor;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class NodeStatistics {
  Resources? system;
  Resources? total;
  Resources? used;
  NodeUsers? users;

  NodeStatistics({
    this.system,
    this.total,
    this.used,
    this.users,
  });

  factory NodeStatistics.fromJson(Map<String, dynamic> json) {
    return NodeStatistics(
      system:
          json['system'] != null ? Resources.fromJson(json['system']) : null,
      total: json['total'] != null ? Resources.fromJson(json['total']) : null,
      used: json['used'] != null ? Resources.fromJson(json['used']) : null,
      users: json['users'] != null ? NodeUsers.fromJson(json['users']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (system != null) data['system'] = system?.toJson();
    if (total != null) data['total'] = total?.toJson();
    if (used != null) data['used'] = used?.toJson();
    if (users != null) data['users'] = users?.toJson();
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class NodeUsers {
  int? deployments;
  int? lastDeploymentTimestamp;
  int? workloads;

  NodeUsers({
    this.deployments,
    this.lastDeploymentTimestamp,
    this.workloads,
  });

  factory NodeUsers.fromJson(Map<String, dynamic> json) {
    return NodeUsers(
      deployments: json['deployments'] ?? 0,
      lastDeploymentTimestamp: json['last_deployment_timestamp'] ?? 0,
      workloads: json['workloads'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (deployments != null) data['deployments'] = deployments;
    if (lastDeploymentTimestamp != null) {
      data['last_deployment_timestamp'] = lastDeploymentTimestamp;
    }
    if (workloads != null) data['workloads'] = workloads;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
