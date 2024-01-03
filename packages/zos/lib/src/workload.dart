part of "../zos.dart";

class ResultStates {
  static const String error = "error";
  static const String ok = "ok";
  static const String deleted = "deleted";
}

class WorkloadTypes {
  static const zmachine = "zmachine";
  static const zmount = "zmount";
  static const network = "network";
  static const zdb = "zdb";
  static const ipv4 = "ipv4";
  static const ip = "ip";
  static const gatewayfqdnproxy = "gateway-fqdn-proxy";
  static const gatewaynameproxy = "gateway-name-proxy";
  static const qsfs = "qsfs";
  static const zlogs = "zlogs";
}

class DeploymentResult {}
