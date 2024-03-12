part of '../signer.dart';

class Signer {
  KeyPair? _keypair;
  KPType? _type;

  Future<void> fromMnemonic(String mnemonic, KPType type) async {
    try {
      if (type.value == KPType.sr25519.value) {
        _keypair = await KeyPair.sr25519.fromMnemonic(mnemonic);
        _type = KPType.sr25519;
      } else if (type.value == KPType.ed25519.value) {
        _keypair = await KeyPair.ed25519.fromMnemonic(mnemonic);
        _type = KPType.ed25519;
      } else {
        throw Exception("Wrong KeyPair type !");
      }
    } catch (e) {
      throw Exception("Failed to create keyPair from mnemonic. Error: $e");
    }
  }

  Future<void> fromSeed(Uint8List seed, KPType type) async {
    try {
      if (type.value == KPType.sr25519) {
        _keypair = await KeyPair.sr25519.fromSeed(seed);
        _type = KPType.sr25519;
      } else if (type.value == KPType.ed25519) {
        _keypair = await KeyPair.ed25519.fromSeed(seed);
        _type = KPType.ed25519;
      } else {
        throw Exception("Wrong KeyPair type !");
      }
    } catch (e) {
      throw Exception("Failed to create keyPair from seed. Error: $e");
    }
  }

  Future<void> fromHexSeed(String hexSeed, KPType type) async {
    try {
      final seed = HEX.decode(hexSeed.replaceAll('0x', ''));
      if (type.value == KPType.sr25519) {
        _keypair = KeyPair.sr25519.fromSeed(Uint8List.fromList(seed));
      } else if (type.value == KPType.ed25519) {
        _keypair = KeyPair.ed25519.fromSeed(Uint8List.fromList(seed));
      } else {
        throw Exception("Wrong KeyPair type !");
      }
    } catch (e) {
      throw Exception("Failed to create keyPair from hex seed. Error: $e");
    }
  }

  Future<Uint8List> sign(String data) async {
    if (_keypair == null) {
      throw Exception("keypair not initialized.");
    }
    try {
      final dataBytes = Uint8List.fromList(utf8.encode(data));
      final signature = _keypair!.sign(dataBytes);
      return signature;
    } catch (e) {
      throw Exception("Failed to sign data. Error: $e");
    }
  }

  Future<bool> verify(Uint8List signature, String data) async {
    if (_keypair == null) {
      throw Exception("keypair not initialized.");
    }
    try {
      final dataBytes = Uint8List.fromList(utf8.encode(data));
      return _keypair!.verify(dataBytes, signature);
    } catch (e) {
      throw Exception("Failed to verify signature. Error: $e");
    }
  }

  Future<KeyPair> keypairFromAddress(String address) async {
    final keyring = Keyring();
    keyring.add(_keypair!);
    final pair = keyring.getByAddress(address);
    return pair;
  }
}
