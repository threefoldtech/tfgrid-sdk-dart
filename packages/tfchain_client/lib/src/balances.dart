import 'package:tfchain_client/generated/dev/types/frame_system/account_info.dart';
import 'package:tfchain_client/tfchain_client.dart';

class QueryBalances {
  final QueryClient client;
  QueryBalances(this.client);

  Future<AccountInfo?> get({required List<int> publicKey}) async {
    final res = await client.api.query.system.account(publicKey);
    return res;
  }
}
