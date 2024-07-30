import './query_return_functions.dart';
enum  OrderBy {
  None,
  id_ASC,
  id_DESC,
  gridVersion_ASC,
  gridVersion_DESC,
  twinID_ASC,
  twinID_DESC,
  accountID_ASC,
  accountID_DESC,
  relay_ASC,
  relay_DESC,
  publicKey_ASC,
  publicKey_DESC,
}

String? parseToString(OrderBy orderby) {
  if (orderby == OrderBy.None) {
    return null;
  }
  return orderby.toString().split('.').last;
}

class TwinQueryOption {
  OrderBy orderby;
  int? limit;
  int? offset;

  //ids options
  bool? idIsNull;
  String? idEq;
  String? idNotEq;
  String? idGt;
  String? idGte;
  String? idLt;
  String? idLte;
  List<String>? idIn;
  List<String>? idNotIn;
  String? idContains;
  String? idNotContains;
  String? idContainsInsensitive;
  String? idNotContainsInsensitive;
  String? idStartsWith;
  String? idNotStartsWith;
  String? idEndsWith;
  String? idNotEndsWith;

  //grid options
  bool? gridVersionisNull;
  int? gridVersionEq;
  int? gridVersionNotEq;
  int? gridVersionGt;
  int? gridVersionGte;
  int? gridVersionLt;
  int? gridVersionLte;
  List<int>? gridVersionIn;
  List<int>? gridVersionNotIn;

  //twins options
  bool? twinIDIsNull;
  int? twinIDEq;
  int? twinIDNotEq;
  int? twinIDGt;
  int? twinIDGte;
  int? twinIDLt;
  int? twinIDLte;
  List<int>? twinIDIn;
  List<int>? twinIDNotIn;

  //account options
  bool? accountIDIsNull;
  String? accountIDEq;
  String? accountIDNotEq;
  String? accountIDGt;
  String? accountIDGte;
  String? accountIDLt;
  String? accountIDLte;
  List<String>? accountIDIn;
  List<String>? accountIDNotIn;
  String? accountIDContains;
  String? accountIDNotContains;
  String? accountIDContainsInsensitive;
  String? accountIDNotContainsInsensitive;
  String? accountIDStartsWith;
  String? accountIDNotStartsWith;
  String? accountIDEndsWith;
  String? accountIDNotEndsWith;

  //relay
  bool? relayIsNull;
  String? relayEq;
  String? relayNotEq;
  String? relayGt;
  String? relayGte;
  String? relayLt;
  String? relayLte;
  List<String>? relayIn;
  List<String>? relayNotIn;
  String? relayContains;
  String? relayNotContains;
  String? relayContainsInsensitive;
  String? relayNotContainsInsensitive;
  String? relayStartsWith;
  String? relayNotStartsWith;
  String? relayEndsWith;
  String? relayNotEndsWith;

  //public keys
  bool? publicKeyIsNull;
  String? publicKeyEq;
  String? publicKeyNotEq;
  String? publicKeyGt;
  String? publicKeyGte;
  String? publicKeyLt;
  String? publicKeyLte;
  List<String>? publicKeyIn;
  List<String>? publicKeyNotIn;
  String? publicKeyContains;
  String? publicKeyNotContains;
  String? publicKeyContainsInsensitive;
  String? publicKeyNotContainsInsensitive;
  String? publicKeyStartsWith;
  String? publicKeyNotStartsWith;
  String? publicKeyEndsWith;
  String? publicKeyNotEndsWith;


  TwinQueryOption({
    //order by 
    this.orderby=OrderBy.None,
    this.limit=null,
    this.offset=null,

    //ids
    this.idIsNull,
    this.idEq,
    this.idNotEq,
    this.idGt,
    this.idGte,
    this.idLt,
    this.idLte,
    this.idIn,
    this.idNotIn,
    this.idContains,
    this.idNotContains,
    this.idContainsInsensitive,
    this.idNotContainsInsensitive,
    this.idStartsWith,
    this.idNotStartsWith,
    this.idEndsWith,
    this.idNotEndsWith,

    //grid
    this.gridVersionisNull,
    this.gridVersionEq,
    this.gridVersionNotEq,
    this.gridVersionGt,
    this.gridVersionGte,
    this.gridVersionLt,
    this.gridVersionLte,
    this.gridVersionIn,
    this.gridVersionNotIn,

    //twins
    this.twinIDIsNull,
    this.twinIDEq,
    this.twinIDNotEq,
    this.twinIDGt,
    this.twinIDGte,
    this.twinIDLt,
    this.twinIDLte,
    this.twinIDIn,
    this.twinIDNotIn,

    //account 
    this.accountIDIsNull,
    this.accountIDEq,
    this.accountIDNotEq,
    this.accountIDGt,
    this.accountIDGte,
    this.accountIDLt,
    this.accountIDLte,
    this.accountIDIn,
    this.accountIDNotIn,
    this.accountIDContains,
    this.accountIDNotContains,
    this.accountIDContainsInsensitive,
    this.accountIDNotContainsInsensitive,
    this.accountIDStartsWith,
    this.accountIDNotStartsWith,
    this.accountIDEndsWith,
    this.accountIDNotEndsWith,

    //relay 
    this.relayIsNull,
    this.relayEq,
    this.relayNotEq,
    this.relayGt,
    this.relayGte,
    this.relayLt,
    this.relayLte,
    this.relayIn,
    this.relayNotIn,
    this.relayContains,
    this.relayNotContains,
    this.relayContainsInsensitive,
    this.relayNotContainsInsensitive,
    this.relayStartsWith,
    this.relayNotStartsWith,
    this.relayEndsWith,
    this.relayNotEndsWith,

    // public Key
    this.publicKeyIsNull,
    this.publicKeyEq,
    this.publicKeyNotEq,
    this.publicKeyGt,
    this.publicKeyGte,
    this.publicKeyLt,
    this.publicKeyLte,
    this.publicKeyIn,
    this.publicKeyNotIn,
    this.publicKeyContains,
    this.publicKeyNotContains,
    this.publicKeyContainsInsensitive,
    this.publicKeyNotContainsInsensitive,
    this.publicKeyStartsWith,
    this.publicKeyNotStartsWith,
    this.publicKeyEndsWith,
    this.publicKeyNotEndsWith,
  });

  @override
  String toString() {
    List<String> queryOptions = [];
    //ids
    addToQueryList(queryOptions, "id_isNull", idIsNull);
    addToQueryList(queryOptions, "id_eq", idEq);
    addToQueryList(queryOptions, "id_not_eq", idNotEq);
    addToQueryList(queryOptions, "id_gt", idGt);
    addToQueryList(queryOptions, "id_gte", idGte);
    addToQueryList(queryOptions, "id_lt", idLt);
    addToQueryList(queryOptions, "id_lte", idLte);
    addToQueryList(queryOptions, "id_in", idIn);
    addToQueryList(queryOptions, "id_not_in", idNotIn);
    addToQueryList(queryOptions, "id_contains", idContains);
    addToQueryList(queryOptions, "id_not_contains", idNotContains);
    addToQueryList(queryOptions, "id_containsInsensitive", idContainsInsensitive);
    addToQueryList(queryOptions, "id_not_containsInsensitive", idNotContainsInsensitive);
    addToQueryList(queryOptions, "id_startsWith", idStartsWith);
    addToQueryList(queryOptions, "id_not_startsWith", idNotStartsWith);
    addToQueryList(queryOptions, "id_endsWith", idEndsWith);
    addToQueryList(queryOptions, "id_not_endsWith", idNotEndsWith);

    //grid
    addToQueryList(queryOptions, "gridVersion_isNull", gridVersionisNull);
    addToQueryList(queryOptions, "gridVersion_eq", gridVersionEq);
    addToQueryList(queryOptions, "gridVersion_not_eq", gridVersionNotEq);
    addToQueryList(queryOptions, "gridVersion_gt", gridVersionGt);
    addToQueryList(queryOptions, "gridVersion_gte", gridVersionGte);
    addToQueryList(queryOptions, "gridVersion_lt", gridVersionLt);
    addToQueryList(queryOptions, "gridVersion_lte", gridVersionLte);
    addToQueryList(queryOptions, "gridVersion_in", gridVersionIn);
    addToQueryList(queryOptions, "gridVersion_not_in", gridVersionNotIn);

    //twins
    addToQueryList(queryOptions, "twinID_isNull", twinIDIsNull);
    addToQueryList(queryOptions, "twinID_eq", twinIDEq);
    addToQueryList(queryOptions, "twinID_not_eq", twinIDNotEq);
    addToQueryList(queryOptions, "twinID_gt", twinIDGt);
    addToQueryList(queryOptions, "twinID_gte", twinIDGte);
    addToQueryList(queryOptions, "twinID_lt", twinIDLt);
    addToQueryList(queryOptions, "twinID_lte", twinIDLte);
    addToQueryList(queryOptions, "twinID_in", twinIDIn);
    addToQueryList(queryOptions, "twinID_not_in", twinIDNotIn);

    //accounts
    addToQueryList(queryOptions, "accountID_isNull", accountIDIsNull);
    addToQueryList(queryOptions, "accountID_eq", accountIDEq);
    addToQueryList(queryOptions, "accountID_not_eq", accountIDNotEq);
    addToQueryList(queryOptions, "accountID_gt", accountIDGt);
    addToQueryList(queryOptions, "accountID_gte", accountIDGte);
    addToQueryList(queryOptions, "accountID_lt", accountIDLt);
    addToQueryList(queryOptions, "accountID_lte", accountIDLte);
    addToQueryList(queryOptions, "accountID_in", accountIDIn);
    addToQueryList(queryOptions, "accountID_not_in", accountIDNotIn);
    addToQueryList(queryOptions, "accountID_contains", accountIDContains);
    addToQueryList(queryOptions, "accountID_not_contains", accountIDNotContains);
    addToQueryList(queryOptions, "accountID_containsInsensitive", accountIDContainsInsensitive);
    addToQueryList(queryOptions, "accountID_not_containsInsensitive", accountIDNotContainsInsensitive);
    addToQueryList(queryOptions, "accountID_startsWith", accountIDStartsWith);
    addToQueryList(queryOptions, "accountID_not_startsWith", accountIDNotStartsWith);
    addToQueryList(queryOptions, "accountID_endsWith", accountIDEndsWith);
    addToQueryList(queryOptions, "accountID_not_endsWith", accountIDNotEndsWith);

    //relay 
    addToQueryList(queryOptions, "relay_isNull", relayIsNull);
    addToQueryList(queryOptions, "relay_eq", relayEq);
    addToQueryList(queryOptions, "relay_not_eq", relayNotEq);
    addToQueryList(queryOptions, "relay_gt", relayGt);
    addToQueryList(queryOptions, "relay_gte", relayGte);
    addToQueryList(queryOptions, "relay_lt", relayLt);
    addToQueryList(queryOptions, "relay_lte", relayLte);
    addToQueryList(queryOptions, "relay_in", relayIn);
    addToQueryList(queryOptions, "relay_not_in", relayNotIn);
    addToQueryList(queryOptions, "relay_contains", relayContains);
    addToQueryList(queryOptions, "relay_not_contains", relayNotContains);
    addToQueryList(queryOptions, "relay_containsInsensitive", relayContainsInsensitive);
    addToQueryList(queryOptions, "relay_not_containsInsensitive", relayNotContainsInsensitive);
    addToQueryList(queryOptions, "relay_startsWith", relayStartsWith);
    addToQueryList(queryOptions, "relay_not_startsWith", relayNotStartsWith);
    addToQueryList(queryOptions, "relay_endsWith", relayEndsWith);
    addToQueryList(queryOptions, "relay_not_endsWith", relayNotEndsWith);

    // public key 
    addToQueryList(queryOptions, "publicKey_isNull", publicKeyIsNull);
    addToQueryList(queryOptions, "publicKey_eq", publicKeyEq);
    addToQueryList(queryOptions, "publicKey_not_eq", publicKeyNotEq);
    addToQueryList(queryOptions, "publicKey_gt", publicKeyGt);
    addToQueryList(queryOptions, "publicKey_gte", publicKeyGte);
    addToQueryList(queryOptions, "publicKey_lt", publicKeyLt);
    addToQueryList(queryOptions, "publicKey_lte", publicKeyLte);
    addToQueryList(queryOptions, "publicKey_in", publicKeyIn);
    addToQueryList(queryOptions, "publicKey_not_in", publicKeyNotIn);
    addToQueryList(queryOptions, "publicKey_contains", publicKeyContains);
    addToQueryList(queryOptions, "publicKey_not_contains", publicKeyNotContains);
    addToQueryList(queryOptions, "publicKey_containsInsensitive", publicKeyContainsInsensitive);
    addToQueryList(queryOptions, "publicKey_not_containsInsensitive", publicKeyNotContainsInsensitive);
    addToQueryList(queryOptions, "publicKey_startsWith", publicKeyStartsWith);
    addToQueryList(queryOptions, "publicKey_not_startsWith", publicKeyNotStartsWith);
    addToQueryList(queryOptions, "publicKey_endsWith", publicKeyEndsWith);
    addToQueryList(queryOptions, "publicKey_not_endsWith", publicKeyNotEndsWith);


    return QueryString(queryOptions.isNotEmpty ? queryOptions.join(', ') : " ",  parseToString(orderby) , limit , offset );
  }
}

class TwinReturnOptions {
  bool accountID;
  bool gridVersion;
  bool publicKey;
  bool relay;
  bool twinID;

  TwinReturnOptions({
    this.accountID = false,
    this.gridVersion = false,
    this.publicKey = false,
    this.relay = false,
    this.twinID = false,
  });

  @override
  String toString() {
    String returnOptions = "id \n";
    returnOptions =addToReturnList(returnOptions ,"accountID" , accountID );
    returnOptions= addToReturnList(returnOptions ,"gridVersion" , gridVersion );
    returnOptions= addToReturnList(returnOptions ,"publicKey" , publicKey );
    returnOptions= addToReturnList(returnOptions ,"relay" , relay );
    returnOptions=addToReturnList(returnOptions ,"twinID" , twinID );
    return returnOptions;
  }

}

class TwinInfo {
  String id;
  String? accountID;
  int? gridVersion;
  String? publicKey;
  String? relay;
  int? twinID;

  TwinInfo({
    required this.id,
    this.gridVersion,
    this.accountID,
    this.publicKey,
    this.relay,
    this.twinID,
  });

    @override
  String toString() {
    return 'TwinInfo(id: $id, accountID: $accountID, gridVersion: $gridVersion, publicKey: $publicKey, relay: $relay, twinID: $twinID)';
  }

}



/*
class TwinConnectionEdgeInfo {
  String? cursor;
  TwinInfo node;   

  TwinConnectionEdgeInfo({
    this.cursor,
    required this.node,
  });
}


class TwinConnection {
  TwinConnectionEdgeInfo edges;
  TwinConnectionPageInfo? pageInfo;
  int? totalCount;

  TwinConnectionEdgeInfo({
    required this.edges,
    this.pageInfo,
    this.totalCount,
  });
}

class TwinConnectionPageInfo {
  String? endCursor;
  bool? hasNextPage;
  bool? hasPreviousPage;
  String? startCursor;

  TwinConnectionPageInfo({
    this.endCursor,
    this.hasNextPage,
    this.hasPreviousPage,
    this.startCursor,
  });
}
*/



