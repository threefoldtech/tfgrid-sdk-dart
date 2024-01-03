library zos;

import 'package:zos/zos.dart';

class Zlogs extends WorkloadData {
  String zmachine;
  String output;

  Zlogs({
    required this.zmachine,
    required this.output,
  });

  String challenge() {
    String out = "";
    out += this.zmachine;
    out += this.output;

    return out;
  }
}
