import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models.dart';
import 'graphql_client.reflectable.dart';

void main() async {
  initializeReflectable();

  final graphQLClient = GraphQLClient('https://graphql.dev.grid.tf/graphql');
  await graphQLClient.twins.twinsConnections(
      TwinConnectionsReturnOptions(),
      TwinConnectionsQueryOptions(
          whereOptions: TwinQueryWhereOptions(gridVersionEq: 1),
          orderby: OrderByOptions.gridVersion_ASC,
          after: 3,
          first: 3));

  await graphQLClient.twins.twins(
    TwinReturnOptions(),
    TwinQueryOptions(orderby: OrderByOptions.id_ASC, limit: 10),
  );
}
