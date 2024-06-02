import 'package:rmb_client/rmb_client.dart';

void main() async {
  final client = Client(
      "wss://relay.dev.grid.tf",
      "wss://tfchain.dev.grid.tf/ws",
      "picnic flip cigar rival risk scatter slide aware trust garlic solution token",
      "session",
      retries: 3,
      keypairType: "ed25519");

  await client.connect();

  // client.closeConnection();
}
