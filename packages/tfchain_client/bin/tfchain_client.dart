import 'package:signer/signer.dart';
import 'package:tfchain_client/models/balances.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() async {
  // final queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
  // queryClient.connect();

  // final balance = await queryClient.balances.get(QueryBalancesGetOptions(
  //     address: "5CLjvFRPw6L2RzjhxLXHzCdRkJJCZ7Px51SN7Wy5TvefuL3b"));
  // print(balance);

  // queryClient.disconnect();

  final client = Client(
      "wss://tfchain.dev.grid.tf/ws",
      "secret add bag cluster deposit beach illness letter crouch position rain arctic",
      "sr25519");
  client.connect();

  final signer = Signer();

  await signer.fromMnemonic(
      "oven strong mention shoulder night ghost correct exercise surge lady jungle hundred",
      KPType.sr25519);

  final extrinsic = await client.clientBalances.transfer(
      BalanceTransferOptions(address: signer.keypair!.address.codeUnits, amount: 10));

  await client.apply(extrinsic);
  // client.disconnect();
}
