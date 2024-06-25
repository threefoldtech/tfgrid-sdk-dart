import 'dart:io';

import 'package:rmb_client/rmb_client.dart';

void main() async {
  final client = Client(
      relayUrl: "wss://relay.dev.grid.tf/",
      chainUrl: "wss://tfchain.dev.grid.tf/ws",
      mnemonic:
          "valid end trumpet hunt produce close hire virus fee rebel gentle claim",
      session: "testclient",
      retries: 3,
      keypairType: "sr25519");

  await client.connect();
  // final ID = await client.send("zos.statistics.get", "{}", 17, 5, 3);

  final ID =
      await client.send("twinserver.balance.getMyBalance", "{}", 7845, 5, 3);

  // sleep(Duration(seconds: 20));

  // await client.read(ID!);

  // await client.send("requestCommand", "requestData", 17, 5, 0);

  // client.closeConnection();
}
