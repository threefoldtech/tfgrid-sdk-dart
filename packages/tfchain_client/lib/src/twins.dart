import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/types/twin.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_runtime/runtime_call.dart';
import 'package:tfchain_client/tfchain_client.dart';

class QueryTwins {
  final QueryClient client;
  QueryTwins(this.client);

  Future<Twin?> get({required int id}) async {
    final res = await client.api.query.tfgridModule.twins(id);
    return res;
  }

  Future<int?> getTwinIdByAccountId({required String address}) async {
    final keyring = Keyring();
    final accountId = keyring.decodeAddress(address);
    final res =
        await client.api.query.tfgridModule.twinIdByAccountID(accountId);
    return res;
  }
}

class Twins extends QueryTwins {
  Twins(Client this.client) : super(client);

  final Client client;

  Future<int?> create({required List<int> relay, required List<int> pk}) async {
    final extrinsic =
        client.api.tx.tfgridModule.createTwin(relay: relay, pk: pk);

    await client.apply(extrinsic);
    return await getTwinIdByAccountId(address: client.address);
  }

  Future<RuntimeCall> update(
      {required List<int> relay, required List<int> pk}) async {
    final extrinsic =
        client.api.tx.tfgridModule.updateTwin(relay: relay, pk: pk);
    return extrinsic;
  }
}
