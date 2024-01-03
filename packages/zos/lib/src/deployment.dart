import 'dart:core';

class KeypairType {
  static const String sr25519 = "sr25519";
  static const String ed25519 = "ed25519";
}

class SignatureRequest {
  int twin_id;
  bool required;
  int weight;

  SignatureRequest({
    required this.twin_id,
    required this.required,
    required this.weight,
  });

  String challenge() {
    String out = "";
    out += this.twin_id as String;
    out += this.required as String;
    out += this.weight as String;

    return out;
  }
}

class Signature {
  int twin_id;
  String signature;
  KeypairType signature_type;

  Signature({
    required this.twin_id,
    required this.signature,
    required this.signature_type,
  });
}

class SignatureRequirement {
  List<SignatureRequest> requests;
  int weight_required;
  List<Signature> signatures;

  SignatureRequirement({
    required this.requests,
    required this.weight_required,
    required this.signatures,
  });

  String challenge() {
    String out = "";
    for (int i = 0; i < this.requests.length; i++) {
      out += this.requests[i].challenge();
    }

    out += this.weight_required as String;
    return out;
  }
}

// TODO:
// class Deployment {
//   int version;
//   int twin_id;
//   int contract_id;
//   int expiration;
//   String metadata;
//   String description;
//   List<Work>
// }
