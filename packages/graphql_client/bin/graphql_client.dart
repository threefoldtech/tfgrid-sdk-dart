import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models.dart';

void main() async {
  final graphQLClient = GraphQLClient('https://graphql.dev.grid.tf/graphql');

  final FarmsReturnOptions farmsReturnOptions = FarmsReturnOptions(
    farmID: true,
    publicIps: PublicIpsReturnOptions(ip: true),
  );
  final FarmsQueryOptions farmsQueryOptions = FarmsQueryOptions(
    idEq: "0000013810-000001-a75c1",
  );

  FarmsConnectionQueryOptions farmsConnectionQueryOptions =
      FarmsConnectionQueryOptions(
          orderBy: FarmsOrderByOptions.id_ASC,
          first: 2,
          after: "10",
          farmIDEq: 10);

  FarmsConnectionReturnOptions farmsConnectionReturnOptions =
      FarmsConnectionReturnOptions(
          pageInfo: true,
          edges: EdgesReturnOptions(
              nodeReturnOptions: NodeReturnOptions(
                  farmID: true, publicIPs: PublicIpsReturnOptions(ip: true))));

  Future<FarmsConnectionInfo> farmsConnection = graphQLClient.farms
      .getFarmsConnection(
          farmsConnectionQueryOptions, farmsConnectionReturnOptions);

  print(await farmsConnection);
}
