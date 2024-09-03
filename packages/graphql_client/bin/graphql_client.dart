import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models.dart';
import 'graphql_client.reflectable.dart';

void main() async {
  initializeReflectable();
  final graphQLClient = GraphQLClient('https://graphql.dev.grid.tf/graphql');

  // final Future<List<ContractBillReports>> contracts = graphQLClient.contracts
  //     .listContractConsumption(BigInt.from(113803), null);

  // for (final contract in await contracts) {
  //   print(contract);
  // }

  final res = await graphQLClient.contracts.listNameContractsByTwinId(
      214, [ContractStates.Deleted], NameContractReturnOptions());
  print(res);

  // Map<String, dynamic> json = {
  //   'id': '0002142268-000002-7ba84',
  //   'gridVersion': 4,
  //   'contractID': '7256',
  //   'twinID': 214,
  //   'state': 'Deleted',
  //   'createdAt': '1662104988',
  //   'solutionProviderID': 0,
  //   'name': 'testt'
  // };

  // var contract = fromJson<NameContract>(json);
  // print(contract);
}
