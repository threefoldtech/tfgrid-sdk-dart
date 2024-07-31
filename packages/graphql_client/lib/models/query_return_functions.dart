
import 'package:graphql_client/models/twins.dart';

void addToQueryList(List<String> list, String key , dynamic value ) {

  if (value is String) {
    list.add('$key: "$value"');
  } else if (value is List<String>) {
    final formattedList = value.map((item) => '"$item"').join(', ');
    list.add('$key: [$formattedList]');

  } else if (value != null) {

    list.add('$key: $value');
  }
}

//TO-DO: check how to send value by referance in dart
String addToReturnList(String returnOptions, String key, bool value) {
  if (value != false) {
    returnOptions += key;
    returnOptions += '\n';
  }
  return returnOptions;
}


String QueryString(String queryOptions, String? orderby , int? limit , int? offset ) {
  if(queryOptions==" " && orderby==null && limit==null && offset==null) return "";
  List<String> queryString = [];
  print(queryOptions);
  if(queryOptions!=" ")queryString.add("where: {$queryOptions}");
  if (orderby!= null) queryString.add("orderBy: $orderby");
  if (limit!= null) queryString.add("limit: $limit");
  if (offset!= null) queryString.add("offset: $offset");
  return "(${queryString.join(', ')})";
}