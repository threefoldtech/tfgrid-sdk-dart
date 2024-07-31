import 'package:graphql_client/models/public_ips.dart';
import 'package:graphql_client/models/query_return_functions.dart';

enum OrderByOptions {
  id_ASC,
  id_DESC,
  gridVersion_ASC,
  gridVersion_DESC,
  farmID_ASC,
  farmID_DESC,
  name_ASC,
  name_DESC,
  twinID_ASC,
  twinID_DESC,
  pricingPolicyID_ASC,
  pricingPolicyID_DESC,
  certification_ASC,
  certification_DESC,
  stellarAddress_ASC,
  stellarAddress_DESC,
  dedicatedFarm_ASC,
  dedicatedFarm_DESC,
}

enum Certification {
  NotCertified,
  Gold,
}

class FarmsReturnOptions {
  bool farmID;
  bool name;
  bool certification;
  bool dedicatedFarm;
  bool pricingPolicyID;
  bool stellarAddress;
  bool twinID;
  PublicIpsReturnOptions? publicIps;

  FarmsReturnOptions({
    this.farmID = false,
    this.name = false,
    this.certification = false,
    this.dedicatedFarm = false,
    this.pricingPolicyID = false,
    this.stellarAddress = false,
    this.twinID = false,
    this.publicIps,
  });

  @override
  String toString() {
    String returnOptions = "id \n";
    returnOptions = addToReturnList(returnOptions, "farmID", farmID);
    returnOptions = addToReturnList(returnOptions, "name", name);
    returnOptions =
        addToReturnList(returnOptions, "certification", certification);
    returnOptions =
        addToReturnList(returnOptions, "dedicatedFarm", dedicatedFarm);
    returnOptions =
        addToReturnList(returnOptions, "pricingPolicyID", pricingPolicyID);
    returnOptions =
        addToReturnList(returnOptions, "stellarAddress", stellarAddress);
    returnOptions = addToReturnList(returnOptions, "twinID", twinID);
    returnOptions =
        addToReturnList(returnOptions, "publicIPs {", publicIps != null);
    returnOptions =
        addToReturnList(returnOptions, publicIps.toString(), publicIps != null);
    returnOptions = addToReturnList(returnOptions, "}", publicIps != null);
    return returnOptions;
  }
}

class FarmsQueryOptions {
  String? idEq;
  String? idGt;
  String? idGte;
  String? idNotEq;
  String? idLt;
  String? idLte;
  String? idContains;
  String? idNotContains;
  String? idContainsInsensitive;
  String? idNotContainsInsensitive;
  String? idStartsWith;
  String? idNotStartsWith;
  String? idEndsWith;
  String? idNotEndsWith;
  List<String>? idIn;
  List<String>? idNotIn;
  bool? gridVersionIsNull;
  int? gridVersionEq;
  int? gridVersionNotEq;
  int? gridVersionGt;
  int? gridVersionGte;
  int? gridVersionLt;
  int? gridVersionLte;
  List<int>? gridVersionIn;
  List<int>? gridVersionNotIn;
  bool? farmIDIsNull;
  int? farmIDEq;
  int? farmIDNotEq;
  int? farmIDGt;
  int? farmIDGte;
  int? farmIDLt;
  int? farmIDLte;
  List<int>? farmIDIn;
  List<int>? farmIDNotIn;
  bool? nameIsNull;
  String? nameEq;
  String? nameNotEq;
  String? nameGt;
  String? nameGte;
  String? nameLt;
  String? nameLte;
  List<String>? nameIn;
  List<String>? nameNotIn;
  String? nameContains;
  String? nameNotContains;
  String? nameContainsInsensitive;
  String? nameNotContainsInsensitive;
  String? nameStartsWith;
  String? nameNotStartsWith;
  String? nameEndsWith;
  String? nameNotEndsWith;
  bool? twinIDIsNull;
  int? twinIDEq;
  int? twinIDNotEq;
  int? twinIDGt;
  int? twinIDGte;
  int? twinIDLt;
  int? twinIDLte;
  List<int>? twinIDIn;
  List<int>? twinIDNotIn;
  bool? pricingPolicyIDIsNull;
  int? pricingPolicyIDEq;
  int? pricingPolicyIDNotEq;
  int? pricingPolicyIDGt;
  int? pricingPolicyIDGte;
  int? pricingPolicyIDLt;
  int? pricingPolicyIDLte;
  List<int>? pricingPolicyIDIn;
  List<int>? pricingPolicyIDNotIn;
  bool? certificationIsNull;
  Certification? certificationEq;
  Certification? certificationNotEq;
  List<Certification>? certificationIn;
  List<Certification>? certificationNotIn;
  bool? stellarAddressIsNull;
  String? stellarAddressEq;
  String? stellarAddressNotEq;
  String? stellarAddressGt;
  String? stellarAddressGte;
  String? stellarAddressLt;
  String? stellarAddressLte;
  List<String>? stellarAddressIn;
  List<String>? stellarAddressNotIn;
  String? stellarAddressContains;
  String? stellarAddressNotContains;
  String? stellarAddressContainsInsensitive;
  String? stellarAddressNotContainsInsensitive;
  String? stellarAddressStartsWith;
  String? stellarAddressNotStartsWith;
  String? stellarAddressEndsWith;
  String? stellarAddressNotEndsWith;
  bool? dedicatedFarmIsNull;
  bool? dedicatedFarmEq;
  bool? dedicatedFarmNotEq;
  int? limit;
  int? offset;
  OrderByOptions? orderBy;

  FarmsQueryOptions({
    this.idEq,
    this.idGt,
    this.idGte,
    this.idNotEq,
    this.idLt,
    this.idLte,
    this.idContains,
    this.idNotContains,
    this.idContainsInsensitive,
    this.idNotContainsInsensitive,
    this.idStartsWith,
    this.idNotStartsWith,
    this.idEndsWith,
    this.idNotEndsWith,
    this.gridVersionIsNull,
    this.gridVersionEq,
    this.gridVersionNotEq,
    this.gridVersionGt,
    this.gridVersionGte,
    this.gridVersionLt,
    this.gridVersionLte,
    this.gridVersionIn,
    this.gridVersionNotIn,
    this.farmIDIsNull,
    this.farmIDEq,
    this.farmIDNotEq,
    this.farmIDGt,
    this.farmIDLte,
    this.farmIDIn,
    this.farmIDNotIn,
    this.nameIsNull,
    this.nameEq,
    this.nameNotEq,
    this.nameGt,
    this.nameGte,
    this.nameLt,
    this.nameLte,
    this.nameIn,
    this.nameNotIn,
    this.nameContains,
    this.nameNotContains,
    this.nameContainsInsensitive,
    this.nameNotContainsInsensitive,
    this.nameStartsWith,
    this.nameNotStartsWith,
    this.nameEndsWith,
    this.nameNotEndsWith,
    this.twinIDIsNull,
    this.twinIDEq,
    this.twinIDNotEq,
    this.twinIDGt,
    this.twinIDGte,
    this.twinIDLt,
    this.twinIDLte,
    this.twinIDIn,
    this.twinIDNotIn,
    this.pricingPolicyIDIsNull,
    this.pricingPolicyIDEq,
    this.pricingPolicyIDNotEq,
    this.pricingPolicyIDGt,
    this.pricingPolicyIDGte,
    this.pricingPolicyIDLt,
    this.pricingPolicyIDLte,
    this.pricingPolicyIDIn,
    this.pricingPolicyIDNotIn,
    this.certificationIsNull,
    this.certificationEq,
    this.certificationNotEq,
    this.certificationIn,
    this.certificationNotIn,
    this.stellarAddressIsNull,
    this.stellarAddressEq,
    this.stellarAddressNotEq,
    this.stellarAddressGt,
    this.stellarAddressGte,
    this.stellarAddressLt,
    this.stellarAddressLte,
    this.stellarAddressIn,
    this.stellarAddressNotIn,
    this.stellarAddressContains,
    this.stellarAddressNotContains,
    this.stellarAddressContainsInsensitive,
    this.stellarAddressNotContainsInsensitive,
    this.stellarAddressStartsWith,
    this.stellarAddressNotStartsWith,
    this.stellarAddressEndsWith,
    this.stellarAddressNotEndsWith,
    this.dedicatedFarmIsNull,
    this.dedicatedFarmEq,
    this.dedicatedFarmNotEq,
    this.limit,
    this.offset,
    this.orderBy,
  });

  @override
  String toString() {
    List<String> queryOptions = [];

    addToQueryList(queryOptions, "id_eq", idEq);
    addToQueryList(queryOptions, "id_gt", idGt);
    addToQueryList(queryOptions, "id_gte", idGte);
    addToQueryList(queryOptions, "id_not_eq", idNotEq);
    addToQueryList(queryOptions, "id_lt", idLt);
    addToQueryList(queryOptions, "id_lte", idLte);
    addToQueryList(queryOptions, "id_contains", idContains);
    addToQueryList(queryOptions, "id_not_contains", idNotContains);
    addToQueryList(
        queryOptions, "id_containsInsensitive", idContainsInsensitive);
    addToQueryList(
        queryOptions, "id_not_containsInsensitive", idNotContainsInsensitive);
    addToQueryList(queryOptions, "id_startsWith", idStartsWith);
    addToQueryList(queryOptions, "id_not_startsWith", idNotStartsWith);
    addToQueryList(queryOptions, "id_endsWith", idEndsWith);
    addToQueryList(queryOptions, "id_not_endsWith", idNotEndsWith);
    addToQueryList(queryOptions, "id_in", idIn);
    addToQueryList(queryOptions, "id_not_in", idNotIn);
    addToQueryList(queryOptions, "gridVersion_is_null", gridVersionIsNull);
    addToQueryList(queryOptions, "gridVersion_eq", gridVersionEq);
    addToQueryList(queryOptions, "gridVersion_not_eq", gridVersionNotEq);
    addToQueryList(queryOptions, "gridVersion_gt", gridVersionGt);
    addToQueryList(queryOptions, "gridVersion_gte", gridVersionGte);
    addToQueryList(queryOptions, "gridVersion_lt", gridVersionLt);
    addToQueryList(queryOptions, "gridVersion_lte", gridVersionLte);
    addToQueryList(queryOptions, "gridVersion_in", gridVersionIn);
    addToQueryList(queryOptions, "gridVersion_not_in", gridVersionNotIn);
    addToQueryList(queryOptions, "farmID_is_null", farmIDIsNull);
    addToQueryList(queryOptions, "farmID_eq", farmIDEq);
    addToQueryList(queryOptions, "farmID_not_eq", farmIDNotEq);
    addToQueryList(queryOptions, "farmID_gt", farmIDGt);
    addToQueryList(queryOptions, "farmID_gte", farmIDGte);
    addToQueryList(queryOptions, "farmID_lt", farmIDLt);
    addToQueryList(queryOptions, "farmID_lte", farmIDLte);
    addToQueryList(queryOptions, "farmID_in", farmIDIn);
    addToQueryList(queryOptions, "farmID_not_in", farmIDNotIn);
    addToQueryList(queryOptions, "name_isNull", nameIsNull);
    addToQueryList(queryOptions, "name_eq", nameEq);
    addToQueryList(queryOptions, "name_not_eq", nameNotEq);
    addToQueryList(queryOptions, "name_gt", nameGt);
    addToQueryList(queryOptions, "name_gte", nameGte);
    addToQueryList(queryOptions, "name_lt", nameLt);
    addToQueryList(queryOptions, "name_lte", nameLte);
    addToQueryList(queryOptions, "name_in", nameIn);
    addToQueryList(queryOptions, "name_not_in", nameNotIn);
    addToQueryList(queryOptions, "name_contains", nameContains);
    addToQueryList(queryOptions, "name_not_contains", nameNotContains);
    addToQueryList(
        queryOptions, "name_containsInsensitive", nameContainsInsensitive);
    addToQueryList(queryOptions, "name_not_containsInsensitive",
        nameNotContainsInsensitive);
    addToQueryList(queryOptions, "name_startsWith", nameStartsWith);
    addToQueryList(queryOptions, "name_not_startsWith", nameNotStartsWith);
    addToQueryList(queryOptions, "name_endsWith", nameEndsWith);
    addToQueryList(queryOptions, "name_not_endsWith", nameNotEndsWith);
    addToQueryList(queryOptions, "twinID_isNull", twinIDIsNull);
    addToQueryList(queryOptions, "twinID_eq", twinIDEq);
    addToQueryList(queryOptions, "twinID_not_eq", twinIDNotEq);
    addToQueryList(queryOptions, "twinID_gt", twinIDGt);
    addToQueryList(queryOptions, "twinID_gte", twinIDGte);
    addToQueryList(queryOptions, "twinID_lt", twinIDLt);
    addToQueryList(queryOptions, "twinID_lte", twinIDLte);
    addToQueryList(queryOptions, "twinID_in", twinIDIn);
    addToQueryList(queryOptions, "twinID_not_in", twinIDNotIn);
    addToQueryList(
        queryOptions, "pricingPolicyID_isNull", pricingPolicyIDIsNull);
    addToQueryList(queryOptions, "pricingPolicyID_eq", pricingPolicyIDEq);
    addToQueryList(
        queryOptions, "pricingPolicyID_not_eq", pricingPolicyIDNotEq);
    addToQueryList(queryOptions, "pricingPolicyID_gt", pricingPolicyIDGt);
    addToQueryList(queryOptions, "pricingPolicyID_gte", pricingPolicyIDGte);
    addToQueryList(queryOptions, "pricingPolicyID_lt", pricingPolicyIDLt);
    addToQueryList(queryOptions, "pricingPolicyID_lte", pricingPolicyIDLte);
    addToQueryList(queryOptions, "pricingPolicyID_in", pricingPolicyIDIn);
    addToQueryList(
        queryOptions, "pricingPolicyID_not_in", pricingPolicyIDNotIn);
    addToQueryList(queryOptions, "certification_isNull", certificationIsNull);
    addToQueryList(queryOptions, "certification_eq", certificationEq);
    addToQueryList(queryOptions, "certification_not_eq", certificationNotEq);
    addToQueryList(queryOptions, "certification_in", certificationIn);
    addToQueryList(queryOptions, "certification_not_in", certificationNotIn);
    addToQueryList(queryOptions, "stellarAddress_isNull", stellarAddressIsNull);
    addToQueryList(queryOptions, "stellarAddress_eq", stellarAddressEq);
    addToQueryList(queryOptions, "stellarAddress_not_eq", stellarAddressNotEq);
    addToQueryList(queryOptions, "stellarAddress_gt", stellarAddressGt);
    addToQueryList(queryOptions, "stellarAddress_gte", stellarAddressGte);
    addToQueryList(queryOptions, "stellarAddress_lt", stellarAddressLt);
    addToQueryList(queryOptions, "stellarAddress_lte", stellarAddressLte);
    addToQueryList(queryOptions, "stellarAddress_in", stellarAddressIn);
    addToQueryList(queryOptions, "stellarAddress_not_in", stellarAddressNotIn);
    addToQueryList(
        queryOptions, "stellarAddress_contains", stellarAddressContains);
    addToQueryList(
        queryOptions, "stellarAddress_not_contains", stellarAddressNotContains);
    addToQueryList(queryOptions, "stellarAddress_containsInsensitive",
        stellarAddressContainsInsensitive);
    addToQueryList(queryOptions, "stellarAddress_not_containsInsensitive",
        stellarAddressNotContainsInsensitive);
    addToQueryList(
        queryOptions, "stellarAddress_startsWith", stellarAddressStartsWith);
    addToQueryList(queryOptions, "stellarAddress_not_startsWith",
        stellarAddressNotStartsWith);
    addToQueryList(
        queryOptions, "stellarAddress_endsWith", stellarAddressEndsWith);
    addToQueryList(
        queryOptions, "stellarAddress_not_endsWith", stellarAddressNotEndsWith);
    addToQueryList(queryOptions, "dedicatedFarm_isNull", dedicatedFarmIsNull);
    addToQueryList(queryOptions, "dedicatedFarm_eq", dedicatedFarmEq);
    addToQueryList(queryOptions, "dedicatedFarm_not_eq", dedicatedFarmNotEq);

    String queryString = '';

    if (queryOptions.isNotEmpty) {
      queryString += 'where: {${queryOptions.join(', ')} }';
    }

    if (limit != null) {
      if (queryString.isNotEmpty) {
        queryString += ', ';
      }
      queryString += 'limit: $limit';
    }

    if (offset != null) {
      if (queryString.isNotEmpty) {
        queryString += ', ';
      }
      queryString += 'offset: $offset';
    }

    if (orderBy != null) {
      if (queryString.isNotEmpty) {
        queryString += ', ';
      }
      queryString += 'orderBy: ${orderBy.toString().split('.').last}';
    }

    if (queryString.isNotEmpty) {
      queryString = '($queryString)';
    }

    return queryString;
  }
}

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
  PublicIpsInfo? publicIps;

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
    this.publicIps,
  });
}
