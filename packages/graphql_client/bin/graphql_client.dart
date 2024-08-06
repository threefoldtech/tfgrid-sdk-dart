import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models.dart';
import 'package:graphql_client/models/contract_state.dart';
import 'graphql_client.reflectable.dart';

void main() async {
  initializeReflectable();
  final graphQLClient = GraphQLClient('https://graphql.dev.grid.tf/graphql');

  final List<ContractStates> contractStates = [
    ContractStates.Created,
    ContractStates.GracePeriod
  ];
  final GqlNodeContractReturnOptions returnOptions =
      GqlNodeContractReturnOptions(
    id: true,
    gridVersion: true,
    contractID: true,
    twinID: true,
    state: true,
    createdAt: true,
    solutionProviderID: true,
    nodeID: true,
    resourcesUsed: ContractUsedResourcesReturnOptions(
      hru: true,
    ),
  );
  final Future<List<GqlNodeContract>> contracts = graphQLClient.contracts
      .listNodeContractsByTwinId(89, contractStates, returnOptions);

  for (final contract in await contracts) {
    print(contract);
  }
}
