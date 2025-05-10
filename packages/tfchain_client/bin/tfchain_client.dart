import 'package:tfchain_client/tfchain_client.dart';

// void main() async {
//   final polkadot =
//       WsProvider(Uri.parse('wss://tfchain.grid.tf'));
//   final api = StateApi(polkadot);
//   print("Attempting to connect (without waiting)...");
//   final connectFuture = await polkadot.connect();
//   print("Attempting to disconnect immediately...");
//   await polkadot.disconnect();
// }

void main() async {
  final client = Client(
      "wss://tfchain.grid.tf/ws",
      "0x7a0b1b8278a85a89640c65ad6f7373f4df203fe23da6b9a48f1c199fe1ed00da",
      "sr25519");
  await client.connect();

  print(client.keypair!.address);

  await client.disconnect();
}
