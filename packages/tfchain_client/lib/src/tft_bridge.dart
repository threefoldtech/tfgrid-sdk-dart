import 'package:tfchain_client/tfchain_client.dart';

class QueryBridge {
  final QueryClient client;
  QueryBridge(this.client);

  Future<BigInt?> getWithdrawFee() async {
    final fee = await client.api.query.tFTBridgeModule.withdrawFee();
    return fee;
  }

  Future<BigInt?> getDepositFee() async {
    final fee = await client.api.query.tFTBridgeModule.depositFee();
    return fee;
  }
}
