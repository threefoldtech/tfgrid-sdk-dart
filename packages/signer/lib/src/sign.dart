part of '../signer.dart';

class Signer {
  KeyPair? keypair;
  KPType? _type;

  Future<KeyPair?> fromMnemonic(String mnemonic, KPType type) async {
    try {
      if (type.value == KPType.sr25519.value) {
        keypair = await KeyPair.sr25519.fromMnemonic(mnemonic);
        _type = KPType.sr25519;
        return keypair;
      } else if (type.value == KPType.ed25519.value) {
        keypair = await KeyPair.ed25519.fromMnemonic(mnemonic);
        _type = KPType.ed25519;
        return keypair;
      } else {
        throw Exception("Wrong KeyPair type !");
      }
    } catch (e) {
      throw Exception("Failed to create keyPair from mnemonic. Error: $e");
    }
  }

  Future<KeyPair?> fromSeed(Uint8List seed, KPType type) async {
    try {
      if (type.value == KPType.sr25519.value) {
        keypair = await KeyPair.sr25519.fromSeed(seed);
        _type = KPType.sr25519;
        return keypair;
      } else if (type.value == KPType.ed25519.value) {
        keypair = await KeyPair.ed25519.fromSeed(seed);
        _type = KPType.ed25519;
        return keypair;
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
      keypair = await fromSeed(Uint8List.fromList(seed), type);
    } catch (e) {
      throw Exception("Failed to create keyPair from hex seed. Error: $e");
    }
  }

  String sign(String data) {
    if (keypair == null) {
      throw Exception("keypair not initialized.");
    }
    try {
      final dataBytes = Uint8List.fromList(utf8.encode(data));
      final signature = keypair!.sign(dataBytes);
      return HEX.encode(signature);
    } catch (e) {
      throw Exception("Failed to sign data. Error: $e");
    }
  }

  bool verify(String signature, String data) {
    if (keypair == null) {
      throw Exception("keypair not initialized.");
    }
    try {
      final dataBytes = Uint8List.fromList(utf8.encode(data));
      final signatureBytes = HEX.decode(signature);
      return keypair!.verify(dataBytes, Uint8List.fromList(signatureBytes));
    } catch (e) {
      throw Exception("Failed to verify signature. Error: $e");
    }
  }

  KeyPair keypairFromAddress(String address) {
    final keyring = Keyring();

    keyring.add(keypair!);
    final pair = keyring.getByAddress(address);
    return pair;
  }
}
