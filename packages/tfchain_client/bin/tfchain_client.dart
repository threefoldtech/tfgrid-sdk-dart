import 'package:tfchain_client/tfchain_client.dart';

void main() async {
  // final queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
  // await queryClient.connect();

  // final twin = await queryClient.twins.get(QueryTwinsGetOptions(id: 214));

  // final twinId = await queryClient.twins.getTwinIdByAccountId(
  //     QueryTwinsGetTwinByAccountIdOptions(accountId: twin!.accountId));
  // print(twinId);

  // await queryClient.disconnect();

  final client = Client(
      "wss://tfchain.dev.grid.tf/ws",
      "secret add bag cluster deposit beach illness letter crouch position rain arctic",
      "sr25519");
  await client.connect();
  // final extrinsic = await client.clientBalances.transfer(
  //     address: "5CJrCjZvsudNoJApTGG5PKcZfhAzAyGqgSK8bysoCV2oRBMC", amount: 10);
  final extrinsic = await client.clientTwins.create(relay: [], pk: []);

  await client.apply(extrinsic);
  // await client.kvStrore.list();

  // await client.disconnect();
}
