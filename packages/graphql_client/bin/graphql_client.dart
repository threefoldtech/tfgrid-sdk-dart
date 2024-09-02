import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models.dart';
// import 'graphql_client.reflectable.dart';

void main() async {
  // initializeReflectable();
  final graphQLClient = GraphQLClient('https://graphql.dev.grid.tf/graphql');

  final queryOptions =
      FarmsQueryOptions(limit: 10, orderBy: FarmsOrderByOptions.farmID_DESC);
  final returnOptions = FarmsReturnOptions(
      id: true,
      farmID: true,
      name: true,
      twinID: true,
      publicIps: PublicIpsReturnOptions(
          ip: true, contractId: true, id: true, gateway: true));

  final farms =
      await graphQLClient.farms.listFarms(queryOptions, returnOptions);

  // final Future<List<ContractBillReports>> contracts = graphQLClient.contracts
  //     .listContractConsumption(BigInt.from(113803), null);

  // for (final contract in await contracts) {
  //   print(contract);
  // }
}
