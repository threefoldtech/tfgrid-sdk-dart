part of signer;

class Signer {
  KeyPair? _keypair;

  Future<void> fromMnemonic(String mnemonic) async {
    _keypair = await KeyPair.fromMnemonic(mnemonic);
  }

  Future<void> fromSeed(Uint8List seed) async {
    _keypair = await KeyPair.fromSeed(seed);
  }

  Future<void> fromHexSeed(String seed) async {
    final hexSeed = HEX.decode(seed.replaceAll('0x', ''));
    _keypair = await KeyPair.fromSeed(Uint8List.fromList(hexSeed));
  }

  Future<Uint8List> sign(Uint8List data) async {
    if (_keypair == null) {
      throw Exception("Keypair not initialized.");
    }

    final signature = await _keypair!.sign(data);
    return signature;
  }

  Future<bool> verify(Uint8List signature, Uint8List data) async {
    if (_keypair == null) {
      throw Exception("Keypair not initialized.");
    }

    return await _keypair!.verify(data, signature);
  }
}
