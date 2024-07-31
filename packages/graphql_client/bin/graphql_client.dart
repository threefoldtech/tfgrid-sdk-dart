import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models/farms.dart';
import 'package:graphql_client/models/public_ips.dart';

void main() async {
  final graphQLClient = GraphQLClient('https://graphql.dev.grid.tf/graphql');

  final FarmsReturnOptions farmsReturnOptions = FarmsReturnOptions(
    farmID: true,
    publicIps: PublicIpsReturnOptions(contractId: true),
  );
  final FarmsQueryOptions farmsQueryOptions = FarmsQueryOptions(
    orderBy: OrderByOptions.id_ASC,
    idEq: "0012174289-000002-ae474",
  );

  Future<List<FarmInfo>> listFarms =
      graphQLClient.farms.listFarms(farmsQueryOptions, farmsReturnOptions);

  listFarms.then((farms) {
    for (var farm in farms) {
      print(farm);
    }
  });
}
