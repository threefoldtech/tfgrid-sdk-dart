import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models.dart';

void main() async {
  final graphQLClient = GraphQLClient('https://graphql.dev.grid.tf/graphql');

  await graphQLClient.nodeResourcesTotals.nodeResourcesTotal(
      NodeResourcesTotalReturnOptions(
          id: true,
          node: NodesReturnOptions(gridVersion: true, certification: true)),
      NodeResourcesTotalQueryOptions(
          orderby: NodeResourcesTotalOrderByOptions.id_ASC,
          limit: 1,
          offset: 2,
          whereOptions: NodeResourcesWhereOptions(idIsNull: false)));

/*
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
          offset: 1,
          orderby: NodesOrderByOptions.id_ASC,
          whereOptions: NodesQueryWhereOptions(
              idIsNull: false,
              uptimeEq: BigInt.one,
              interfacesEvery: InterfaceWhereOptions(
                  idIsNull: false,
                  node: NodesQueryWhereOptions(idIsNull: false)),
              location: LocationWhereOptions(idIsNull: false),
              resourcesTotal: NodeResourcesWhereOptions(
                  idIsNull: false,
                  node: NodesQueryWhereOptions(idIsNull: false)),
              power: PowerWhereOptions(stateIsNull: true),
              publicConfig: PublicConfigWhereOptions(
                  idIsNull: false,
                  node: NodesQueryWhereOptions(idIsNull: false)))));




  await graphQLClient.twins.twinsConnections(
      TwinConnectionsReturnOptions(
          totalCount: true,
          edges: TwinConnectionsEdgeReturnOptions(
              cursor: true,
              node: TwinReturnOptions(accountID: true, gridVersion: true))),
      TwinConnectionsQueryOptions(
          whereOptions: TwinQueryWhereOptions(gridVersionEq: 1),
          orderby: TwinOrderByOptions.gridVersion_ASC,
          after: 3,
          first: 3));

  await graphQLClient.twins.twins(
    TwinReturnOptions(accountID: true, relay: true, twinID: true),
    TwinQueryOptions(orderby: TwinOrderByOptions.id_ASC, limit: 10),
  );
  */
}
