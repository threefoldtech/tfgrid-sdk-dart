import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:tfchain_client/generated/dev/types/frame_system/account_info.dart';
import 'package:tfchain_client/generated/dev/types/sp_runtime/multiaddress/multi_address.dart';
import 'package:tfchain_client/tfchain_client.dart';

class QueryBalances {
  QueryClient client;
  QueryBalances(this.client);

  Future<AccountInfo?> get({required String address}) async {
    final keyring = Keyring();
    final publicKey = keyring.decodeAddress(address);
    final res = await client.api.query.system.account(publicKey);
    return res;
  }
}

class Balances extends QueryBalances {
  Balances(Client this.client) : super(client);

  final Client client;

  Future<void> transfer(
      {required String address, required BigInt amount}) async {
    if (amount <= BigInt.zero) {
      throw Exception("Amount must be a positive numeric value");
    }

    final keyring = Keyring();
    final publicKey = keyring.decodeAddress(address);
    MultiAddress multiAddress = Id(publicKey);

    final extrinsic = client.api.tx.balances
        .transfer(dest: multiAddress, value: amount * BigInt.from(10).pow(7));
    await client.apply(extrinsic);
  }

  Future<AccountInfo?> getMyBalance() async {
    return await this.get(address: client.address);
  }
}
