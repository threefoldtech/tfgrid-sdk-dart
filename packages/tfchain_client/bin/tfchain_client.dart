import 'package:tfchain_client/tfchain_client.dart';
import '../../signer/lib/signer.dart';

void main() async {
  final client = QueryClient("wss://tfchain.dev.grid.tf/ws");
  client.connect();

  // QueryBalances Module
  final signer = Signer();
  await signer.fromMnemonic(
      'picnic flip cigar rival risk scatter slide aware trust garlic solution token');
  final pair = await signer
      .keypairFromAddress("5CoYEiMb2ePY4cAW7f18HM7rozePwtQ8Ny5yKx8qYUGWxdgi");
  final balance = await client.balances.get(publicKey: pair.publicKey.bytes);
  print(balance!.toJson());

  print("==================");

  // QueryContracts Module
  final contract = await client.contracts.get(contractId: BigInt.from(49130));
  print(contract!.toJson());

  print("==================");

  final contractId =
      await client.contracts.getContractIdByActiveRentForNode(nodeId: 85);
  print(contractId);

  print("==================");

  final activeContracts = await client.contracts.getActiveContracts(nodeId: 85);
  print(activeContracts);

  print("==================");

  final id =
      await client.contracts.getContractIdByNodeIdAndHash(nodeId: 11, hash: [
    53,
    50,
    57,
    102,
    53,
    99,
    50,
    55,
    97,
    50,
    99,
    97,
    51,
    50,
    48,
    49,
    48,
    97,
    98,
    102,
    102,
    102,
    49,
    52,
    100,
    56,
    54,
    51,
    52,
    102,
    53,
    51
  ]);
  print(id);

  print("==================");

  final contractLock =
      await client.contracts.contractLock(id: BigInt.from(49130));
  print(contractLock!.toJson());

  print("==================");

  // Farms Module
  final farm = await client.farms.get(id: 115);
  print(farm!.toJson());

  print("==================");

  // Nodes Module
  final node = await client.nodes.get(id: 85);
  print(node!.toJson());

  print("==================");

  // Twins Module
  final twin = await client.twins.get(id: 214);
  print(twin!.toJson());

  print("==================");

  final twinId = await client.twins.getTwinIdByAccountId(accountId: [
    12,
    58,
    221,
    236,
    167,
    151,
    69,
    84,
    126,
    190,
    116,
    100,
    140,
    251,
    60,
    149,
    249,
    60,
    238,
    70,
    203,
    93,
    75,
    150,
    70,
    130,
    0,
    28,
    253,
    137,
    178,
    63
  ]);

  print(twinId);

  client.disconnect();
}
