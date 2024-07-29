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
}

class PublicIpsReturnOptions {}

class PublicIpsQueryOptions {}
