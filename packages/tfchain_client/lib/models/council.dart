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

class ProposalInfo {
  String module;
  String method;
  Map<String, dynamic> args;

  ProposalInfo(
      {required this.module, required this.method, required this.args});

  factory ProposalInfo.fromJson(Map<String, Map<String, dynamic>> json) {
    final argsJson = json.values.first.values.first;
    final Map<String, dynamic> args = {};
    if (argsJson != null) {
      for (final entry in argsJson.entries) {
        if (entry.value == null) {
          args[entry.key] = entry.value;
        } else {
          args[entry.key] = String.fromCharCodes(entry.value);
        }
      }
    }
    return ProposalInfo(
        module: json.keys.first,
        method: json.values.first.keys.first,
        args: args);
  }
}
