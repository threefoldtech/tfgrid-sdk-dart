// ignore_for_file: constant_identifier_names

enum TwinSortBy {
  relay,
  public_key,
  account_id,
  twin_id;

  @override
  String toString() {
    return name;
  }
}

enum TwinSortOrder {
  desc,
  asc;

  @override
  String toString() {
    return name;
  }
}

class TwinsQueryParams {
  int? page;
  int? size;
  bool? retCount;
  bool? randomize;
  TwinSortBy? sortBy;
  TwinSortOrder? sortOrder;
  int? twinID;
  String? accountID;
  String? relay;
  String? publicKey;

  TwinsQueryParams({
    this.page,
    this.size,
    this.retCount,
    this.randomize,
    this.sortBy,
    this.sortOrder,
    this.twinID,
    this.accountID,
    this.relay,
    this.publicKey,
  });

  Map<String, dynamic> toMap() {
    final queryParameters = {
      if (page != null) 'page': page,
      if (size != null) 'size': size,
      if (retCount != null) 'ret_count': retCount,
      if (randomize != null) 'randomize': randomize,
      if (sortBy != null) 'sort_by': sortBy,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (twinID != null) 'twin_id': twinID,
      if (accountID != null) 'account_id': accountID,
      if (relay != null) 'relay': relay,
      if (publicKey != null) 'public_key': publicKey,
    };
    return queryParameters;
  }
}

class TwinsInfo {
  String accountID;
  String publicKey;
  String relay;
  int twinID;

  TwinsInfo({
    required this.accountID,
    required this.publicKey,
    required this.relay,
    required this.twinID,
  });

  factory TwinsInfo.fromJson(Map<String, dynamic> json) {
    return TwinsInfo(
      accountID: json['accountId'] ?? '',
      publicKey: json['publicKey'] ?? '',
      relay: json['relay'] ?? '',
      twinID: json['twinId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'twinId': twinID,
      'accountId': accountID.isEmpty ? '""' : accountID,
      'relay': relay.isEmpty ? '""' : relay,
      'publicKey': publicKey.isEmpty ? '""' : publicKey,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class TwinConsumption {
  double lastHourConsumption;
  double overallConsumption;

  TwinConsumption({
    required this.lastHourConsumption,
    required this.overallConsumption,
  });

  factory TwinConsumption.fromJson(Map<String, dynamic> json) {
    return TwinConsumption(
      lastHourConsumption: double.parse(json['last_hour_consumption'] != null
          ? json['last_hour_consumption'].toString()
          : '0.0'),
      overallConsumption: double.parse(json['overall_consumption'] != null
          ? json['overall_consumption'].toString()
          : '0.0'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_hour_consumption': lastHourConsumption,
      'overall_consumption': overallConsumption,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
