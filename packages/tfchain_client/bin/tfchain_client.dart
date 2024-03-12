import 'package:tfchain_client/models/dao.dart';
import 'package:tfchain_client/tfchain_client.dart';

void main() async {
  final queryClient = QueryClient("wss://tfchain.dev.grid.tf/ws");
  queryClient.connect();

  queryClient.disconnect();

  // final client = Client("wss://tfchain.dev.grid.tf/ws",
  //     "secret add bag cluster deposit beach illness letter crouch position rain arctic");
  // client.connect();
}
