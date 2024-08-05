import 'package:tfchain_client/tfchain_client.dart';

void main() async {
  final client =
      Client("wss://tfchain.dev.grid.tf/ws", "your-mnemonic", "sr25519");
  await client.connect();

  final twinId = await client.twins.create(relay: "", pk: []);

  print(twinId);
  // await client.kvStrore.list();

  // await client.disconnect();
}
