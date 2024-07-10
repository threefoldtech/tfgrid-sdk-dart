import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:tfchain_client/generated/dev/types/frame_system/account_info.dart';
import 'package:tfchain_client/generated/dev/types/sp_runtime/multiaddress/multi_address.dart';
import 'package:tfchain_client/generated/dev/types/tfchain_runtime/runtime_call.dart';
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
  Balances(Client client) : super(client) {
    this.client = client;
  }

  Future<RuntimeCall> transfer(
      {required String address, required int amount}) async {
    if (amount.isNaN || amount <= 0) {
      throw Exception("Amount must be a positive numeric value");
    }
    final keyring = Keyring();
    final publicKey = keyring.decodeAddress(address);
    MultiAddress multiAddress = Address32(publicKey);

    final extrinsic =
        client.api.tx.balances.transfer(dest: multiAddress, value: BigInt.from(amount));
    return extrinsic;
  }

  // Future<AccountInfo?> getMyBalance() async {
  //   return await this
  // }
}
