import 'dart:convert';

import 'package:polkadart_keyring/polkadart_keyring.dart';

import '../lib/signer.dart';
import 'dart:typed_data';

// Just for testing will be deleted soon
import 'package:convert/convert.dart';

void main() async {
  final keyring = Keyring();

  final mnemonic =
      'picnic flip cigar rival risk scatter slide aware trust garlic solution token';
  final signer1 = Signer();
  await signer1.fromMnemonic(mnemonic);
  final data = Uint8List.fromList([6, 7, 8, 9, 10]);
  final signatureFromMnemonic = await signer1.sign(data);

  final seedUint8List = Uint8List.fromList([
    108,
    29,
    148,
    202,
    167,
    191,
    10,
    13,
    126,
    240,
    152,
    60,
    24,
    35,
    233,
    172,
    106,
    190,
    213,
    114,
    33,
    213,
    125,
    9,
    34,
    101,
    67,
    82,
    216,
    92,
    177,
    228
  ]);

  final signer2 = Signer();
  await signer2.fromSeed(seedUint8List);
  final signatureFromSeed = await signer2.sign(data);

  final signer3 = Signer();
  await signer3.fromHexSeed(
      '0x6c1d94caa7bf0a0d7ef0983c1823e9ac6abed57221d57d0922654352d85cb1e4');
  final signatureFromSeed2 = await signer3.sign(data);

  // print('Signature from mnemonic: ${signatureFromMnemonic}');
  print('Signature from seed: ${signatureFromSeed}');
  print('Signature from seed2: ${signatureFromSeed2}');

  final res = await signer1.verify(signatureFromMnemonic, data);
  print(res);
}
