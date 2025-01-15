import 'package:stellar_client/stellar_client.dart';

void main() async {
  final stellarClient = await Client(NetworkType.PUBLIC,
      'SCVWI4TCVUPB7EN4I5X5DQ56RV5E3JNFWDY2NHJCBXOMH5WKVCJ4RSGG');

  await stellarClient.getTransactions();
}
