import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models/contracts.dart';
import 'package:graphql_client/models/farms.dart';
import 'package:graphql_client/models/public_ips.dart';
import 'package:graphql_client/src/contracts.dart';
import 'package:graphql_client/models/twins.dart';
import 'package:graphql_client/src/twins.dart';

void main() async {
  final graphQLClient = GraphQLClient('https://graphql.dev.grid.tf/graphql');

  final FarmsReturnOptions farmsReturnOptions = FarmsReturnOptions(
    farmID: true,
    publicIps: PublicIpsReturnOptions(contractId: true),
  );
  final FarmsQueryOptions farmsQueryOptions = FarmsQueryOptions(
    orderBy: OrderByOptions.id_ASC,
  );

  Future<List<FarmInfo>> listFarms =
      graphQLClient.farms.listFarms(farmsQueryOptions, farmsReturnOptions);
}
