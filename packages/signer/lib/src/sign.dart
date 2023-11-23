part of signer;

class Signer {
  late KeyPair _keyring;

  Future<void> fromMnemonic(String mnemonic) async {
    _keyring = await KeyPair.fromMnemonic(mnemonic);
  }

  Future<void> fromSeed(Uint8List seed) async {
    _keyring = await KeyPair.fromSeed(seed);
  }

  Future<Uint8List> sign(Uint8List data) async {
    if (_keyring == Null) {
      throw Exception(
          "Keyring not initialized. Call the appropriate constructor first.");
    }

    final signature = await _keyring.sign(data);
    return signature;
  }

  Future<bool> verify(Uint8List signature, Uint8List data) async {
    if (_keyring == Null) {
      throw Exception(
          "Keyring not initialized. Call the appropriate constructor first.");
    }

    return await _keyring.verify(data, signature);
  }
}