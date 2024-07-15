part of '../signer.dart';
// TODO: should return keypair or not ?

class Signer {
  KeyPair? keypair;

  Future<KeyPair?> fromMnemonic(String mnemonic, KPType type) async {
    try {
      if (type == KPType.sr25519) {
        keypair = await KeyPair.sr25519.fromMnemonic(mnemonic);
      } else if (type == KPType.ed25519) {
        keypair = await KeyPair.ed25519.fromMnemonic(mnemonic);
      }
      return keypair;
    } catch (e) {
      throw Exception("Failed to create keyPair from mnemonic. Error: $e");
    }
  }

  KeyPair? fromSeed(Uint8List seed, KPType type) {
    try {
      if (type == KPType.sr25519) {
        keypair = KeyPair.sr25519.fromSeed(seed);
      } else if (type == KPType.ed25519) {
        keypair = KeyPair.ed25519.fromSeed(seed);
      }
      return keypair;
    } catch (e) {
      throw Exception("Failed to create keyPair from seed. Error: $e");
    }
  }

  void fromHexSeed(String hexSeed, KPType type) {
    try {
      final seed = HEX.decode(hexSeed.replaceAll('0x', ''));
      keypair = fromSeed(Uint8List.fromList(seed), type);
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
}
