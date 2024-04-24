import 'dart:io';

import 'package:signer/signer.dart';
import 'package:tfchain_client/models/balances.dart';
import 'package:tfchain_client/models/kvstore.dart';
import 'package:tfchain_client/models/twins.dart';
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

  // await client.apply(extrinsic);
  client.kvStrore.list();

  // await client.disconnect();
}
