import 'package:stellar_client/stellar_client.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

void main() async {
  final stellarClient = Client(NetworkType.TESTNET);
  final mnemonic = await Wallet.generate24WordsMnemonic();
  final keyPair =
      await stellarClient.createThreefoldAccount(mnemonic: mnemonic);
  print(keyPair!.accountId);
}
