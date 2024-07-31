part of '../models.dart';

class PublicIpsInfo {
  String id;
  String? contractId;
  String? ip;
  String? gateway;

  PublicIpsInfo({
    required this.id,
    this.contractId,
    this.ip,
    this.gateway,
  });

  factory PublicIpsInfo.fromJson(Map<String, dynamic> json) {
    return PublicIpsInfo(
      id: json['id'],
      contractId: json['contractId'] ?? "",
      ip: json['ip'] ?? "",
      gateway: json['gateway'] ?? "",
    );
  }
}

class PublicIpsReturnOptions {
  bool contractId;
  bool ip;
  bool gateway;

  PublicIpsReturnOptions({
    this.contractId = false,
    this.ip = false,
    this.gateway = false,
  });

  @override
  String toString() {
    String returnOptions = "id \n";
    returnOptions = _addToReturnList(returnOptions, "contractId", contractId);
    returnOptions = _addToReturnList(returnOptions, "ip", ip);
    returnOptions = _addToReturnList(returnOptions, "gateway", gateway);
    return returnOptions;
  }
}

class PublicIpsQueryOptions {}
