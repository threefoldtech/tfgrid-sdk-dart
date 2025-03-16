import 'package:stellar_client/stellar_client.dart';

void main() async {
  final stellarClient = Client(NetworkType.PUBLIC,
      'SCVWI4TCVUPB7EN4I5X5DQ56RV5E3JNFWDY2NHJCBXOMH5WKVCJ4RSGG');
  // print({stellarClient.accountId, stellarClient.secretSeed});
  // print(await stellarClient.getBalance());
  final balance = await getBalanceByAccountID(
      network: NetworkType.PUBLIC,
      accountId: 'GBE366DFQTLJNQSAWAE2YSGLAPXS4MZMJPCIBKWCHUUKMQLIJ2PNUIFC');

  print('balanceeeee: $balance');
}
