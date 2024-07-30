import './query_return_functions.dart';
class TwinQueryOption {
  bool? idIsNull;
  String? idEq;
  String? idNotEq;
  String? idGt;
  String? idGte;
  String? idLt;
  String? idLte;
  //List<String>? idIn;
  //List<String>? idNotIn;
  String? idContains;
  String? idNotContains;
  String? idContainsInsensitive;
  String? idNotContainsInsensitive;
  String? idStartsWith;
  String? idNotStartsWith;
  String? idEndsWith;
  String? idNotEndsWith;

  TwinQueryOption({
    this.idIsNull,
    this.idEq,
    this.idNotEq,
    this.idGt,
    this.idGte,
    this.idLt,
    this.idLte,
    //this.idIn,
    //this.idNotIn,
    this.idContains,
    this.idNotContains,
    this.idContainsInsensitive,
    this.idNotContainsInsensitive,
    this.idStartsWith,
    this.idNotStartsWith,
    this.idEndsWith,
    this.idNotEndsWith,
  });

  @override
  String toString() {
    List<String> queryOptions = [];
    addToQueryList(queryOptions, "id_eq", idEq);
    addToQueryList(queryOptions, "id_not_eq", idNotEq);
    addToQueryList(queryOptions, "id_gt", idGt);
    addToQueryList(queryOptions, "id_gte", idGte);
    addToQueryList(queryOptions, "id_lt", idLt);
    addToQueryList(queryOptions, "id_lte", idLte);
    //addToQueryList(queryOptions, "id_in", idIn);
    //addToQueryList(queryOptions, "id_not_in", idNotIn);
    addToQueryList(queryOptions, "id_contains", idContains);
    addToQueryList(queryOptions, "id_not_contains", idNotContains);
    addToQueryList(queryOptions, "id_contains_insensitive", idContainsInsensitive);
    addToQueryList(queryOptions, "id_not_contains_insensitive", idNotContainsInsensitive);
    addToQueryList(queryOptions, "id_starts_with", idStartsWith);
    addToQueryList(queryOptions, "id_not_starts_with", idNotStartsWith);
    addToQueryList(queryOptions, "id_ends_with", idEndsWith);
    addToQueryList(queryOptions, "id_not_ends_with", idNotEndsWith);
    return queryOptions.isNotEmpty ? '(where: {${queryOptions.join(', ')} })' : '';
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
