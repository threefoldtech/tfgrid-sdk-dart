class KVStoreSetOptions {
  String key;
  String value;

  KVStoreSetOptions({
    required this.key,
    required this.value,
  });
}

class KVStoreGetOptions {
  String key;

  KVStoreGetOptions({required this.key});
}
