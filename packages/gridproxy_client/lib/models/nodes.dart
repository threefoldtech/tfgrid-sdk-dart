import 'package:gridproxy_client/models/reflector.dart';
import 'package:gridproxy_client/src/query_builder.dart';

class GetNodeStatusOptions {
  int nodeID;

  GetNodeStatusOptions({
    required this.nodeID,
  });
}

@reflector
class ListNodesQueryParamaters {
  int? page;
  int? size;
  bool? ret_count;
  bool? randomize;
  String? sort_by;
  String? sort_order;
  String? balance;
  int? free_mru;
  int? free_hru;
  int? free_sru;
  int? total_mru;
  int? total_cru;
  int? total_sru;
  int? total_hru;
  int? free_ips;
  String? status;
  bool? healthy;
  bool? has_ipv6;
  String? city;
  String? country;
  String? region;
  String? farm_name;
  bool? ipv4;
  bool? ipv6;
  bool? domain;
  bool? dedicated;
  bool? in_dedicated_farm;
  bool? rentable;
  bool? rented;
  int? rented_by;
  int? available_for;
  String? farm_ids;
  String? certification_type;
  bool? has_gpu;
  String? gpu_device_id;
  String? gpu_device_name;
  String? gpu_vendor_id;
  String? gpu_vendor_name;
  bool? gpu_available;
  int? owned_by;
  String? price_min;
  String? price_max;

  ListNodesQueryParamaters({
    this.page,
    this.size,
    this.ret_count,
    this.randomize,
    this.sort_by,
    this.sort_order,
    this.balance,
    this.free_mru,
    this.free_hru,
    this.free_sru,
    this.total_mru,
    this.total_cru,
    this.total_sru,
    this.total_hru,
    this.free_ips,
    this.status,
    this.healthy,
    this.has_ipv6,
    this.city,
    this.country,
    this.region,
    this.farm_name,
    this.ipv4,
    this.ipv6,
    this.domain,
    this.dedicated,
    this.in_dedicated_farm,
    this.rentable,
    this.rented,
    this.rented_by,
    this.available_for,
    this.farm_ids,
    this.certification_type,
    this.has_gpu,
    this.gpu_device_id,
    this.gpu_device_name,
    this.gpu_vendor_id,
    this.gpu_vendor_name,
    this.gpu_available,
    this.owned_by,
    this.price_min,
    this.price_max,
  });

  Map<String, dynamic> toJson() {
    return toMap(this);
  }
}

@reflector
class Node {
  String? certificationType;
  String? city;
  String? country;
  int? created;
  bool? dedicated;
  Dmi? dmi;
  int? extraFee;
  int? farmID;
  String? farmName;
  int? farmingPolicyId;
  int? gridVersion;
  bool? healthy;
  String? id;
  bool? inDedicatedFarm;
  Location? location;
  int? nodeID;
  int? numGpu;
  Power? power;
  double? priceUsd;
  PublicConfig? publicConfig;
  int? rentContractID;
  bool? rentable;
  bool? rented;
  int? rentedByTwinID;
  String? serialNumber;
  Speed? speed;
  String? status;
  Resources? totalResources;
  int? twinID;
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
    this.farmID,
    this.farmName,
    this.farmingPolicyId,
    this.gridVersion,
    this.healthy,
    this.id,
    this.inDedicatedFarm,
    this.location,
    this.nodeID,
    this.numGpu,
    this.power,
    this.priceUsd,
    this.publicConfig,
    this.rentContractID,
    this.rentable,
    this.rented,
    this.rentedByTwinID,
    this.serialNumber,
    this.speed,
    this.status,
    this.totalResources,
    this.twinID,
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
      farmID: json['farmId'] ?? 0,
      farmName: json['farmName'] ?? '',
      farmingPolicyId: json['farmingPolicyId'] ?? 0,
      gridVersion: json['gridVersion'] ?? 0,
      healthy: json['healthy'] ?? false,
      id: json['id'] ?? '',
      inDedicatedFarm: json['inDedicatedFarm'] ?? false,
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      nodeID: json['nodeId'] ?? 0,
      numGpu: json['num_gpu'] ?? 0,
      power: json['power'] != null ? Power.fromJson(json['power']) : null,
      priceUsd: json['price_usd'].toDouble() ?? 0,
      publicConfig: json['publicConfig'] != null
          ? PublicConfig.fromJson(json['publicConfig'])
          : null,
      rentContractID: json['rentContractId'] ?? 0,
      rentable: json['rentable'] ?? false,
      rented: json['rented'] ?? false,
      rentedByTwinID: json['rentedByTwinId'] ?? 0,
      serialNumber: json['serialNumber'] ?? '',
      speed: json['speed'] != null ? Speed.fromJson(json['speed']) : null,
      status: json['status'] ?? '',
      twinID: json['twinId'] ?? 0,
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
class Speed {
  double? download;
  int? nodeTwinID;
  double? upload;

  Speed({
    this.download,
    this.nodeTwinID,
    this.upload,
  });

  factory Speed.fromJson(Map<String, dynamic> json) {
    return Speed(
      download: json['download'].toDouble() ?? 0.0,
      nodeTwinID: json['node_twin_id'] ?? 0,
      upload: json['upload'].toDouble() ?? 0.0,
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
class NodeGPUInfo {
  int? contract;
  String? device;
  String? id;
  int? nodeTwinID;
  int? updatedAt;
  String? vendor;

  NodeGPUInfo({
    this.contract,
    this.device,
    this.id,
    this.nodeTwinID,
    this.updatedAt,
    this.vendor,
  });

  factory NodeGPUInfo.fromJson(Map<String, dynamic> json) {
    return NodeGPUInfo(
      contract: json['contract'],
      device: json['device'],
      id: json['id'],
      nodeTwinID: json['node_twin_id'],
      updatedAt: json['updated_at'],
      vendor: json['vendor'],
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
