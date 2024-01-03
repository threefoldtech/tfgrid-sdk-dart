library zos;

import 'package:zos/zos.dart';

class ZdbModes {
  static const String seq = "seq";
  static const String user = "user";
}

class Zdb extends WorkloadData {
  int size; // in bytes
  ZdbModes mode = ZdbModes.seq as ZdbModes;
  String password;
  bool public;

  Zdb({
    required this.size,
    String mode = 'seq',
    required this.password,
    required this.public,
  });

  String challenge() {
    String out = "";
    out += size.toString();
    out += mode.toString();
    out += password;
    out += public.toString();

    return out;
  }
}

class ZdbResult extends WorkloadDataResult {
  String Namespace;
  List<String> Ips;
  int Port;

  ZdbResult({
    required this.Namespace,
    required this.Ips,
    required this.Port,
  });
}
