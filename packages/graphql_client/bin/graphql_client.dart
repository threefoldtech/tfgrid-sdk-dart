import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models.dart';
import 'graphql_client.reflectable.dart';

void main() async {
  initializeReflectable();

  final graphQLClient = GraphQLClient('https://graphql.dev.grid.tf/graphql');

  await graphQLClient.nodes.nodeResourcesTotalConnection(
      NodeResourcesTotalsConnectionReturnOptions(),
      NodeResourcesTotalsConnectionQueryOptions());

  await graphQLClient.nodes.nodeResourcesTotal(
      NodeResourcesTotalReturnOptions(), NodeResourcesTotalQueryOptions());

  await graphQLClient.nodes.nodes(
      NodesReturnOptions(
        city: true,
        location: LocationReturnOptions(latitude: true),
        resourcesTotal: NodeResourcesTotalReturnOptions(
            mru: true, node: NodesReturnOptions(createdAt: true)),
        power: NodePowerReturnOptions(state: true),
        publicConfig: PublicConfigReturnOptions(
            ipv4: true, node: NodesReturnOptions(createdAt: true)),
        interfaces: InterfacesReturnOptions(
            name: true, node: NodesReturnOptions(createdAt: true)),
      ),
      NodesQueryOptions(
        limit: 1,
      ));

  await graphQLClient.twins.twinsConnections(
      TwinConnectionsReturnOptions(),
      TwinConnectionsQueryOptions(
          whereOptions: TwinQueryWhereOptions(gridVersionEq: 1),
          orderby: TwinOrderByOptions.gridVersion_ASC,
          after: 3,
          first: 3));

  await graphQLClient.twins.twins(
    TwinReturnOptions(),
    TwinQueryOptions(orderby: TwinOrderByOptions.id_ASC, limit: 10),
  );
}
