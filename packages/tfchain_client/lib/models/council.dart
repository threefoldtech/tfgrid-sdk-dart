import 'package:moment_dart/moment_dart.dart';

class CouncilProposal {
  int index;
  int threshold;
  Moment end;
  String hash;
  String module;
  String method;
  Map<String, dynamic> args;
  bool active;

  CouncilProposal({
    required this.index,
    required this.threshold,
    required this.end,
    required this.hash,
    required this.module,
    required this.method,
    required this.args,
    required this.active,
  });
}
