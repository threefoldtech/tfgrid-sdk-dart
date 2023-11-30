import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/types/twin.dart';
import 'package:tfchain_client/generated/dev/types/sp_core/crypto/account_id32.dart';
import 'package:tfchain_client/tfchain_client.dart';

class QueryTwins {
  final QueryClient client;
  QueryTwins(this.client);

  Future<Twin?> get({required int id}) async {
    final res = await client.api.query.tfgridModule.twins(id);
    return res;
  }

  Future<int?> getTwinIdByAccountId({required List<int> accountId}) async {
    final res = await client.api.query.tfgridModule.twinIdByAccountID(accountId);
    return res;
  }
}
