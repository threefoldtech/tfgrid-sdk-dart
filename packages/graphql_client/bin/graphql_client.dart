import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models/contracts.dart';
import 'package:graphql_client/models/farms.dart';
import 'package:graphql_client/src/contracts.dart';
import 'package:graphql_client/models/twins.dart';
import 'package:graphql_client/src/twins.dart';

void main() async {
  final graphQLClient = GraphQLClient('https://graphql.dev.grid.tf/graphql');

  Future<List<FarmInfo>> Farms = graphQLClient.farms
      .listFarmsByTwinId(ListFarmsByTwinIdOptions(twinId: 214));

  // final contracts = await graphQLClient.contracts
  //     .listContractsByTwinId(ListContractByTwinIdOptions(twinId: 5110));
  // var res = 0.0;

  // final nameContracts = contracts.nameContracts;
  // print(nameContracts.length);
  // for (final x in nameContracts) {
  //   print(x.contractID);
  //   final consumption = await graphQLClient.contracts
  //       .getConsumption(GetConsumptionOptions(contractID: x.contractID));
  //   res += consumption;
  // }

  // final nodeContracts = contracts.nodeContracts;
  // print(nodeContracts.length);
  // for (final x in nodeContracts) {
  //   print(x.contractID);
  //   final consumption = await graphQLClient.contracts
  //       .getConsumption(GetConsumptionOptions(contractID: x.contractID));
  //   res += consumption;
  // }
  // print("HEllo");
  // print(res * 24 * 30);
  // await graphQLClient.contracts
  //     .getConsumption(GetConsumptionOptions(contractID: "54069"));
}
