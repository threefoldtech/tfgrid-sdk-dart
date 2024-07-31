
part of '../models.dart';


void _addToQueryList(List<String> list, String key, dynamic value) {
  switch (value.runtimeType) {
    case String:
      list.add('$key: "$value"');
      break;
    case const (List<String>):
      final formattedList =
          (value as List<String>).map((item) => '"$item"').join(', ');
      list.add('$key: [$formattedList]');
      break;
    default:
      if (value != null) {
        list.add('$key: $value');
      }
      break;
  }
}


String _addToReturnList(String returnOptions, String key, bool value) {
  if (value != false) {
    returnOptions += key;
    returnOptions += '\n';
  }
  return returnOptions;
}
