import 'dart:convert';

import '../lib/signer.dart';
import 'dart:typed_data';

// Just for testing will be deleted soon

void main() async {
  final mnemonic =
      'picnic flip cigar rival risk scatter slide aware trust garlic solution token';
  final signer1 = Signer();
  await signer1.fromMnemonic(mnemonic);
  final data = Uint8List.fromList([6, 7, 8, 9, 10]);
  final signatureFromMnemonic = await signer1.sign(data);

  final seed = '12345678901234567890123456789012';
  final seedUint8List = Uint8List.fromList(utf8.encode(seed));
  final signer2 = Signer();
  await signer2.fromSeed(seedUint8List);
  final signatureFromSeed = await signer2.sign(data);

  print('Signature from mnemonic: ${signatureFromMnemonic}');
  print('Signature from seed: ${signatureFromSeed}');

  final res = await signer1.verify(signatureFromMnemonic, data);
  print(res);
}
