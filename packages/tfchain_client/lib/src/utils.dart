import 'dart:typed_data';

bool isValidSeed(String seed) {
  final RegExp hexRegex = RegExp(r'^[0-9a-fA-F]+$');
  return hexRegex.hasMatch(seed);
}

Uint8List dynamicListToUint8List(dynamicList) {
  List<int> intList = dynamicList.cast<int>().toList();
  Uint8List data = Uint8List.fromList(intList);
  return data;
}
