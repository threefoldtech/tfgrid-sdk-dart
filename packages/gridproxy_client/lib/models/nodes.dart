import 'package:gridproxy_client/models/reflector.dart';
import 'package:gridproxy_client/models/sort_order.dart';
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
  sortOrder? sort_order;
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
  int? farmId;
  String? farmName;
  int? farmingPolicyId;
  int? gridVersion;
  bool? healthy;
  String? id;
  bool? inDedicatedFarm;
  Location? location;
  int? nodeId;
  int? num_gpu;
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
  Resources? total_resources;
  int? twinId;
  int? updatedAt;
  int? uptime;
  Resources? used_resources;

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
    this.num_gpu,
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
    this.total_resources,
    this.twinId,
    this.updatedAt,
    this.uptime,
    this.used_resources,
  });

  factory Node.fromJson(Map<String, dynamic> json) {
    return fromJson(json);
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
  int? node_twin_id;
  List<Processor>? processor;

  Dmi({
    this.baseboard,
    this.bios,
    this.memory,
    this.node_twin_id,
    this.processor,
  });

  factory Dmi.fromJson(Map<String, dynamic> json) {
    return fromJson(json);
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
    return fromJson(json);
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
    return fromJson(json);
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
  String? thread_count;
  String? version;

  Processor({
    this.thread_count,
    this.version,
  });

  factory Processor.fromJson(Map<String, dynamic> json) {
    return fromJson(json);
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
    return fromJson(json);
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
    return fromJson(json);
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
    return fromJson(json);
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
  int? node_twin_id;
  double? upload;

  Speed({
    this.download,
    this.node_twin_id,
    this.upload,
  });

  factory Speed.fromJson(Map<String, dynamic> json) {
    return fromJson(json);
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
  String? product_name;

  Baseboard({
    this.manufacturer,
    this.product_name,
  });

  factory Baseboard.fromJson(Map<String, dynamic> json) {
    return fromJson(json);
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
    return fromJson(json);
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
  int? node_twin_id;
  int? updated_at;
  String? vendor;

  NodeGPUInfo({
    this.contract,
    this.device,
    this.id,
    this.node_twin_id,
    this.updated_at,
    this.vendor,
  });

  factory NodeGPUInfo.fromJson(Map<String, dynamic> json) {
    return fromJson(json);
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
    return fromJson(json);
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
    return fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
