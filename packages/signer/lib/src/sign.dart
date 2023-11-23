part of signer;

class Signer {
  KeyPair? _keypair;

  Future<void> fromMnemonic(String mnemonic) async {
    try {
      _keypair = await KeyPair.fromMnemonic(mnemonic);
    } catch (e) {
      throw Exception("Failed to create keypair from mnemonic. Error: $e");
    }
  }

  Future<void> fromSeed(Uint8List seed) async {
    try {
      _keypair = await KeyPair.fromSeed(seed);
    } catch (e) {
      throw Exception("Failed to create keypair from seed. Error: $e");
    }
  }

  Future<void> fromHexSeed(String seed) async {
    try {
      final hexSeed = HEX.decode(seed.replaceAll('0x', ''));
      _keypair = await KeyPair.fromSeed(Uint8List.fromList(hexSeed));
    } catch (e) {
      throw Exception("Failed to create keypair from hex seed. Error: $e");
    }
  }

  Future<Uint8List> sign(Uint8List data) async {
    if (_keypair == null) {
      throw Exception("Keypair not initialized.");
    }
    try {
      final signature = await _keypair!.sign(data);
      return signature;
    } catch (e) {
      throw Exception("Failed to sign data. Error: $e");
    }
  }

  Future<bool> verify(Uint8List signature, Uint8List data) async {
    if (_keypair == null) {
      throw Exception("Keypair not initialized.");
    }
    try {
      return await _keypair!.verify(data, signature);
    } catch (e) {
      throw Exception("Failed to verify signature. Error: $e");
    }
  }
}
