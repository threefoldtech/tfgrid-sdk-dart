import 'package:tfchain_client/generated/dev/types/tfchain_support/types/farm.dart';
import 'package:tfchain_client/tfchain_client.dart';

class QueryFarms {
  final QueryClient client;
  QueryFarms(this.client);

  Future<Farm?> get({required int id}) async {
    final res = await client.api.query.tfgridModule.farms(id);
    return res as Farm;
  }
}
