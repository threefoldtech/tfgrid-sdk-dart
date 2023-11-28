import 'package:tfchain_client/tfchain_client.dart';

void main() async {
  final client = QueryClient("wss://tfchain.dev.grid.tf/ws");
  client.connect();
  // final id = await client.contracts.get(contractId: BigInt.from(49130));
  // print(id!.twinId);

  // await client.contracts.getDeletionTime(id: BigInt.from(49130));

  // final id =
  //     await client.contracts.getContractIdByActiveRentForNode(nodeId: 11);
  // print(id);

  final fee = await client.contracts.getDedicatedNodeExtraFee(nodeId: 86);
  print("Fee $fee");
}
