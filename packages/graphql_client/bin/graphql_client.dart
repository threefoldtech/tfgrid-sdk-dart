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
          whereOptions: TwinWhereOptions(gridVersionEq: 1),
          orderby: OrderBy.gridVersionAsc,
          after: 3,
          first: 3));

  await graphQLClient.twins.twins(
    TwinReturnOptions(accountID: true, relay: true, twinID: true),
    TwinQueryOptions(orderby: OrderBy.idAsc, limit: 10),
  );

  Future<List<FarmInfo>> listFarms =
      graphQLClient.farms.listFarms(farmsQueryOptions, farmsReturnOptions);


}
