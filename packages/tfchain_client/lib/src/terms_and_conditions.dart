import 'package:tfchain_client/tfchain_client.dart';

class TermsAndConditions {
  final Client client;
  TermsAndConditions(this.client);

  Future<void> accept(
      {required String documentLink, required List<int> documentHash}) async {
    final extrinsic = await client.api.tx.tfgridModule.userAcceptTc(
        documentLink: documentLink.codeUnits, documentHash: documentHash);
    await client.apply(extrinsic);
  }
}
