import 'dart:typed_data';

import 'package:rmb_client/rmb_client.dart';
import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/types/twin.dart';
import 'package:tfchain_client/models/twins.dart';
import 'package:tfchain_client/tfchain_client.dart' as TFClient;

Future<Twin> getTwin(
    int id, Map<int, TwinsMap> twins, TFClient.QueryClient tfclient) async {
  TwinsMap? mappedTwin = twins[id];
  bool isValid = false;

  if (mappedTwin != null) {
    DateTime timestamp =
        DateTime.fromMillisecondsSinceEpoch(mappedTwin.timestamp * 1000);
    DateTime validTime = DateTime.now().subtract(Duration(minutes: 10));
    isValid = timestamp.isAfter(validTime);
  }

  Twin? twin;
  if (mappedTwin != null && isValid) {
    twin = mappedTwin.twin;
  } else {
    twin = await tfclient.twins.get(QueryTwinsGetOptions(id: id));
    twins[id] =
        TwinsMap(twin!, (DateTime.now().millisecondsSinceEpoch / 1000).round());
  }

  return twin;
}

Uint8List hexStringToArrayBuffer(String hexString) {
  // remove the leading 0x
  hexString = hexString.replaceFirst(RegExp(r'^0x'), '');

  // ensure even number of characters
  if (hexString.length % 2 != 0) {
    print("WARNING: expecting an even number of characters in the hexString");
  }

  // check for some non-hex characters
  final bad = RegExp(r'[^0-9A-Fa-f]').allMatches(hexString);
  if (bad.isNotEmpty) {
    print("WARNING: found non-hex characters");
    for (var match in bad) {
      print("Non-hex character: ${match.group(0)} at position ${match.start}");
    }
  }

  // split the string into pairs of octets
  final pairs = RegExp(r'.{1,2}')
      .allMatches(hexString)
      .map((match) => match.group(0))
      .where((s) => s != null)
      .map((s) => s!)
      .toList();

  // convert the octets to integers
  final integers = pairs.map((s) => int.parse(s, radix: 16)).toList();

  return Uint8List.fromList(integers);
}
