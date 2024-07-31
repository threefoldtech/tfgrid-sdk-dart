import 'package:graphql_client/models/twins.dart';

void addToQueryList(List<String> list, String key, dynamic value) {
  if (value is String) {
    list.add('$key: "$value"');
  } else if (value is List<String>) {
    final formattedList = value.map((item) => '"$item"').join(', ');
    list.add('$key: [$formattedList]');
  } else if (value != null) {
    list.add('$key: $value');
  }
}

String addToReturnList(String returnOptions, String key, bool value) {
  if (value != false) {
    returnOptions += key;
    returnOptions += '\n';
  }
  return returnOptions;
}
