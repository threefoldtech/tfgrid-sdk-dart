// ignore_for_file: constant_identifier_names

import 'package:gridproxy_client/models/reflector.dart';
import 'package:gridproxy_client/src/query_builder.dart';

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

@reflector
class TwinsQueryParams {
  int? page;
  int? size;
  bool? ret_count;
  bool? randomize;
  TwinSortBy? sort_by;
  TwinSortOrder? sort_order;
  int? twin_id;
  String? account_id;
  String? relay;
  String? public_key;

  TwinsQueryParams({
    this.page,
    this.size,
    this.ret_count,
    this.randomize,
    this.sort_by,
    this.sort_order,
    this.twin_id,
    this.account_id,
    this.relay,
    this.public_key,
  });

  Map<String, dynamic> toJson() {
    return toMap(this);
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@reflector
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
    return toMap(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
