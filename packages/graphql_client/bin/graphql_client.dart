import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models.dart';

void main() async {
  final graphQLClient = GraphQLClient('https://graphql.dev.grid.tf/graphql');
  await graphQLClient.twins.twinsConnections(
      TwinConnectionsReturnOptions(
          totalCount: true,
          edges: TwinConnectionsEdgeReturnOptions(
              cursor: true,
              node: TwinReturnOptions(accountID: true, gridVersion: true))),
      TwinConnectionsQueryOptions(
          whereOptions: TwinQueryWhereOptions(gridVersionEq: 1),
          orderby: OrderByOptions.gridVersion_ASC,
          after: 3,
          first: 3));

  await graphQLClient.twins.twins(
    TwinReturnOptions(accountID: true, relay: true, twinID: true),
    TwinQueryOptions(orderby: OrderByOptions.id_ASC, limit: 10),
  );

  Future<List<FarmInfo>> listFarms =
      graphQLClient.farms.listFarms(farmsQueryOptions, farmsReturnOptions);


}
