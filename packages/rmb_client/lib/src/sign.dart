import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadart_keyring/polkadart_keyring.dart';

class KPType {
  static const sr25519 = "sr25519"; //not supported
  static const ed25519 = "ed25519";
}

// payload can be either string or unit8list, here only ed25519 is supported
Uint8List sign(Uint8List payload, KeyPair signer) {
  // remove last element from payload list
  final newPayload = Uint8List.fromList(payload.sublist(0, payload.length - 1));

  // String resultString = String.fromCharCodes(newPayload);

  String typePrefix = "e";

  final sig = signer.sign(newPayload);

  Uint8List uint8List = Uint8List.fromList(utf8.encode(typePrefix));

  int prefix = uint8List.elementAt(0);

  Uint8List sigPrefixed = Uint8List.fromList([prefix, ...sig]);

  return sigPrefixed;
}
