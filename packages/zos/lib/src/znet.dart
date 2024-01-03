class Peer {
  String subnet;
  String wireguard_public_key;
  List<String> allowed_ips;
  String endpoint;

  Peer(
      {required this.subnet,
      required this.wireguard_public_key,
      required this.allowed_ips,
      required this.endpoint});

  String challenge() {
    String out = "";
    out += this.wireguard_public_key;
    out += this.endpoint;
    out += this.subnet;

    for (int i = 0; i < this.allowed_ips.length; i++) {
      out += this.allowed_ips[i];
    }
    return out;
  }
}
