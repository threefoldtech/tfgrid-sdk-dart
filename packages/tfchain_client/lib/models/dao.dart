import 'package:moment_dart/moment_dart.dart';
import 'package:tfchain_client/generated/dev/types/pallet_dao/proposal/vote_weight.dart';

class Proposal {
  int threshold;
  List<VoteWeight> ayes;
  List<VoteWeight> nayes;
  List<List<int>> vetos;
  Moment end;
  String hash;
  String action;
  String description;
  String link;
  int ayesProgress;
  int nayesProgress;

  Proposal({
    required this.threshold,
    required this.ayes,
    required this.nayes,
    required this.vetos,
    required this.end,
    required this.hash,
    required this.action,
    required this.description,
    required this.link,
    required this.ayesProgress,
    required this.nayesProgress,
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
