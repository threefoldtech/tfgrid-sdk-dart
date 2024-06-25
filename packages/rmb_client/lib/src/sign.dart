import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/ecc/ecc_fp.dart';
import 'package:pointycastle/export.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart' show KeyPair;
import 'package:cryptography/cryptography.dart' as crypto;
import 'package:pointycastle/ecc/api.dart' as api;

class KPType {
  static const sr25519 = "sr25519";
  static const ed25519 = "ed25519";
}

Uint8List sign(Uint8List payload, KeyPair signer) {
  // remove last element from payload list
  // final newPayload = Uint8List.fromList(payload.sublist(0, payload.length - 1));

  // String resultString = String.fromCharCodes(newPayload);
  String typePrefix = "";
  if (signer.keyPairType.name == KPType.ed25519) {
    typePrefix = "e";
  } else if (signer.keyPairType.name == KPType.sr25519) {
    typePrefix = "s";
  }

  final sig = signer.sign(payload);

  Uint8List uint8List = Uint8List.fromList(utf8.encode(typePrefix));

  int prefix = uint8List.elementAt(0);

  Uint8List sigPrefixed = Uint8List.fromList([prefix, ...sig]);

  return sigPrefixed;
}

bool isProbPub(Uint8List item) {
  return item.length == 33 || item.length == 65;
}

Uint8List _bigIntToUint8List(BigInt number) {
  var _byteArray = number.toRadixString(16).padLeft(64, '0');
  return Uint8List.fromList(hex.decode(_byteArray));
}

BigInt _uint8ListToBigInt(Uint8List uint8List) {
  return BigInt.parse(hex.encode(uint8List), radix: 16);
}

// ECPrivateKey normalizePrivateKey(Uint8List privateKey) {
//   final d = BigInt.parse(hex.encode(privateKey), radix: 16);
//   final params = ECDomainParameters('secp256r1');
//   return ECPrivateKey(d, params);
// }

// ECPublicKey normalizePublicKey(Uint8List publicKey, api.ECCurve curve) {
//   final q = curve.decodePoint(publicKey);
//   if (q == null) {
//     throw ArgumentError('Invalid public key');
//   }
//   final params = ECDomainParameters('secp256r1');
//   return ECPublicKey(q, params);
// }

/// Normalize scalar value.
// BigInt normalizeScalar(BigInt scalar) {
//   final domainParams = ECCurve_secp256r1();
//   final curveOrder = domainParams.n;
//   if (scalar >= BigInt.zero && scalar < curveOrder) {
//     return scalar;
//   } else {
//     return scalar % curveOrder;
//   }
// }

/// Perform point multiplication on an elliptic curve.
// api.ECPoint multiply(BigInt scalar, api.ECPoint affinePoint,
//     {bool useEndomorphism = false}) {
//   final n = normalizeScalar(scalar);
//   api.ECPoint point, fake;

//   if (useEndomorphism) {
//     final splitScalars = splitScalarEndo(n);
//     final k1 = splitScalars['k1']!;
//     final k2 = splitScalars['k2']!;
//     final k1p = affinePoint * k1;
//     final k2p = affinePoint * k2;

//     point = k1p + k2p;
//   } else {
//     point = affinePoint * n;
//   }

//   return point.normalize();
// }

Future<List<int>> getSharedSecret(Uint8List privateA, Uint8List publicB) async {
  try {
    print('Starting getSharedSecret function');
    // final curve = ECCurve_secp256r1();
    // final domainParams = ECDomainParameters('secp256r1');

    // if (!isProbPub(privateA)) {
    //   throw ArgumentError('getSharedSecret: first arg must be private key');
    // }
    // if (!isProbPub(publicB)) {
    //   throw ArgumentError('getSharedSecret: second arg must be public key');
    // }

    // final normalizedPrivateA = normalizePrivateKey(privateA);
    // final normalizedPublicB = normalizePublicKey(publicB, domainParams.curve);

    // // Multiply the keys
    // final sharedSecret = normalizedPublicB * normalizedPrivateA.d;

    // return toRawBytes(sharedSecret, isCompressed);
    // final sharedSecret = normalizedPublicB * normalizedPrivateA.d;

    // return toRawBytes(sharedSecret, isCompressed);

    final params = ECCurve_secp256r1();
    final curve = params.curve;
    print('Curve and parameters initialized');

    // Create private key parameters
    final dA = _uint8ListToBigInt(privateA);
    final privateKey = ECPrivateKey(dA, params);
    print('Private key created');

    print('Public key (hex): ${hex.encode(publicB)}');
    print('Public key length: ${publicB.length}');

    final Q = curve.decodePoint(publicB);
    if (Q == null) {
      throw ArgumentError('Failed to decode public key');
    }
    print('Public key decoded');
    final publicKeyParams = ECPublicKey(Q, params);

    final keyAgreement = ECDHBasicAgreement();
    keyAgreement.init(privateKey);

    final sharedSecret = keyAgreement.calculateAgreement(publicKeyParams);
    print('Shared secret calculated');

    final sharedSecretBytes = _bigIntToUint8List(sharedSecret);
    print('Shared Secret (hex): ${hex.encode(sharedSecretBytes)}');
    return sharedSecretBytes;
  } catch (error) {
    throw Exception('Error computing shared secret: $error');
  }
}

// Future<List<int>> getSharedSecret(Uint8List privateA, Uint8List publicB) async {
//   try {
//     print('Starting getSharedSecret function');
//     final algorithm = crypto.Ecdh.p256(length: 256);

//     print('Algorithm initialized');

//     final localKeyPair = crypto.SimpleKeyPairData(privateA,
//         publicKey:
//             crypto.SimplePublicKey(publicB, type: crypto.KeyPairType.p256),
//         type: crypto.KeyPairType.p256);
//     print('Local key pair created: $localKeyPair');

//     final remotePublicKey =
//         crypto.SimplePublicKey(publicB, type: crypto.KeyPairType.p256);
//     print('Remote public key created: $remotePublicKey');

//     final sharedSecretKey = await algorithm.sharedSecretKey(
//         keyPair: localKeyPair, remotePublicKey: remotePublicKey);
//     print('SharedSecretKey computed');
//     final res = await sharedSecretKey.extractBytes();
//     return res;
//   } catch (error) {
//     throw Exception('Error computing shared secret: $error');
//   }
// }
