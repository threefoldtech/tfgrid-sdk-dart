library zos;

import 'package:zos/zos.dart';

class ZNetworkInterface {
  String network;
  String ip;

  ZNetworkInterface({
    required this.network,
    required this.ip,
  });
}

class ZMachineNetwork {
  String publicIp;
  List<ZNetworkInterface> interfaces;
  bool planetary;

  ZMachineNetwork({
    required this.publicIp,
    required this.interfaces,
    required this.planetary,
  });

  String challenge() {
    String out = '';
    out += publicIp;
    out += planetary.toString();
    for (int i = 0; i < interfaces.length; i++) {
      out += interfaces[i].network;
      out += interfaces[i].ip;
    }
    return out;
  }
}

class Mount {
  String name;
  String mountpoint;

  Mount({
    required this.name,
    required this.mountpoint,
  });

  String challenge() {
    String out = "";
    out += this.name;
    out += this.mountpoint;
    return out;
  }
}

class Zmachine extends WorkloadData {
  String flist;
  ZMachineNetwork network;
  int size; // in bytes
  // TODO:

  Zmachine({
    required this.flist,
    required this.network,
    required this.size,
  });
}
