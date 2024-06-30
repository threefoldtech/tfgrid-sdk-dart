import 'package:tfchain_client/generated/dev/types/tfchain_runtime/runtime_call.dart';
import 'package:tfchain_client/tfchain_client.dart';

class TermsAndConditions {
  final Client client;
  TermsAndConditions(this.client);

  Future<RuntimeCall> accept(
      {required String documentLink, required String documentHash}) async {
    final extrinsic = await client.api.tx.tfgridModule.userAcceptTc(
        documentLink: documentLink, documentHash: documentHash);
    return extrinsic;
  }
}
