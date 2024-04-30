import 'dart:math';

import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models/contract_state.dart';
import 'package:graphql_client/models/contracts.dart';

class TFContracts {
  final GraphQLClient gqlClient;

  TFContracts(this.gqlClient);

  Future<GqlContracts> listContractsByTwinId(
      ListContractByTwinIdOptions options) async {
    options.stateList ??= [
      ContractStates.Created.value,
      ContractStates.GracePeriod.value
    ];

    final state = '[${options.stateList!.join(', ')}]';

    final opts =
        '(where: {twinID_eq: ${options.twinId}, state_in: $state}, orderBy: twinID_ASC)';
    try {
      final nameContractsCount =
          await gqlClient.getItemTotalCount('nameContracts', opts);
      final nodeContractsCount =
          await gqlClient.getItemTotalCount('nodeContracts', opts);
      final rentContractsCount =
          await gqlClient.getItemTotalCount('rentContracts', opts);

      final body = '''
  query getContracts(
    \$nameContractsCount: Int!,
    \$nodeContractsCount: Int!,
    \$rentContractsCount: Int!
  ) {
    nameContracts(
      where: { twinID_eq: ${options.twinId}, state_in: $state },
      limit: \$nameContractsCount
    ) {
      contractID
      createdAt
      name
      solutionProviderID
      state
      twinID
    }
    
    nodeContracts(
      where: { twinID_eq: ${options.twinId}, state_in: $state },
      limit: \$nodeContractsCount
    ) {
      contractID
      deploymentData
      state
      createdAt
      nodeID
      numberOfPublicIPs
    }
    
    rentContracts(
      where: { twinID_eq: ${options.twinId}, state_in: $state },
      limit: \$rentContractsCount
    ) {
      contractID
      createdAt
      nodeID
      solutionProviderID
      state
      twinID
    }
  }''';

      // Executing the GraphQL query
      final response = await gqlClient.query(body, variables: {
        'nodeContractsCount': nodeContractsCount,
        'nameContractsCount': nameContractsCount,
        'rentContractsCount': rentContractsCount,
      });

      List<GqlNameContract> nameContracts =
          (response['data']['nameContracts'] as List<dynamic>)
              .map((contractData) {
        return GqlNameContract(
          contractID: contractData['contractID'] ?? '',
          twinID: contractData['twinID'] ?? 0,
          state: contractData['state'] ?? '',
          createdAt: contractData['createdAt'] ?? '',
          solutionProviderID: contractData['solutionProviderID'] ?? 0,
          name: contractData['name'] ?? '',
        );
      }).toList();

      List<GqlNodeContract> nodeContracts =
          (response['data']['nodeContracts'] as List<dynamic>)
              .map((contractData) {
        return GqlNodeContract(
          contractID: contractData['contractID'] ?? '',
          twinID: contractData['twinID'] ?? 0,
          state: contractData['state'] ?? '',
          createdAt: contractData['createdAt'] ?? '',
          solutionProviderID: contractData['solutionProviderID'] ?? 0,
          nodeID: contractData['nodeID'] ?? 0,
          deploymentData: contractData['deploymentData'] ?? '',
          deploymentHash: contractData['deploymentHash'] ?? '',
          numberOfPublicIPs: contractData['numberOfPublicIPs'] ?? 0,
        );
      }).toList();

      List<GqlRentContract> rentContracts =
          (response['data']['rentContracts'] as List<dynamic>)
              .map((contractData) {
        return GqlRentContract(
          contractID: contractData['contractID'] ?? '',
          twinID: contractData['twinID'] ?? 0,
          state: contractData['state'] ?? '',
          createdAt: contractData['createdAt'] ?? '',
          solutionProviderID: contractData['solutionProviderID'] ?? 0,
          nodeID: contractData['nodeID'] ?? 0,
        );
      }).toList();

      return GqlContracts(
          nameContracts: nameContracts,
          nodeContracts: nodeContracts,
          rentContracts: rentContracts);
    } catch (err) {
      throw err;
    }
  }

  Future<double> getConsumption(GetConsumptionOptions options) async {
    final body = '''
query getConsumption(\$contractId: BigInt!) {
  contractBillReports(where: {contractID_eq: \$contractId}, limit: 2, orderBy: timestamp_DESC) {
    amountBilled
    timestamp
    discountReceived
  }
  nameContracts(where: {contractID_eq: \$contractId}) {
    contractID
    createdAt
    name
    solutionProviderID
    state
    twinID
  }  
  nodeContracts(where: {contractID_eq: \$contractId}) {
    contractID
    deploymentData
    state
    createdAt
    nodeID
    numberOfPublicIPs
  }
  rentContracts(where: {contractID_eq: \$contractId}) {
    contractID
    createdAt
    nodeID
    solutionProviderID
    state
    twinID
  }
}
''';

    try {
      final response = await gqlClient.query(body, variables: {
        'contractId': options.contractID,
      });

      List<dynamic> contractBillReportsData =
          response['data']['contractBillReports'];
      List<dynamic> nodeContractsData = response['data']['nodeContracts'];
      List<dynamic> nameContractsData = response['data']['nameContracts'];
      List<dynamic> rentContractsData = response['data']['rentContracts'];

      List<GqlContractBillReports> contractBillReports =
          contractBillReportsData.map((data) {
        return GqlContractBillReports(
          id: data['id'] ?? '',
          contractID: data['contractID'] ?? 0,
          discountLevel: parseDiscountLevel(data['discountReceived']),
          amountBilled: data['amountBilled'] ?? '',
          timeStamp: data['timestamp'] ?? '',
        );
      }).toList();

      List<GqlNodeContract> nodeContracts = nodeContractsData.map((data) {
        return GqlNodeContract(
          contractID: data['contractID'] ?? '',
          twinID: data['twinID'] ?? 0,
          state: data['state'] ?? '',
          createdAt: data['createdAt'] ?? '',
          solutionProviderID: data['solutionProviderID'] ?? 0,
          nodeID: data['nodeID'] ?? 0,
          deploymentData: data['deploymentData'] ?? '',
          deploymentHash: data['deploymentHash'] ?? '',
          numberOfPublicIPs: data['numberOfPublicIPs'] ?? 0,
        );
      }).toList();

      List<GqlNameContract> nameContracts = nameContractsData.map((data) {
        return GqlNameContract(
          contractID: data['contractID'] ?? '',
          twinID: data['twinID'] ?? 0,
          state: data['state'] ?? '',
          createdAt: data['createdAt'] ?? '',
          solutionProviderID: data['solutionProviderID'] ?? 0,
          name: data['name'] ?? '',
        );
      }).toList();

      List<GqlRentContract> rentContracts = rentContractsData.map((data) {
        return GqlRentContract(
          contractID: data['contractID'] ?? '',
          twinID: data['twinID'] ?? 0,
          state: data['state'] ?? '',
          createdAt: data['createdAt'] ?? '',
          solutionProviderID: data['solutionProviderID'] ?? 0,
          nodeID: data['nodeID'] ?? 0,
        );
      }).toList();

      GqlConsumption gqlConsumption = GqlConsumption(
          contracts: GqlContracts(
              nameContracts: nameContracts,
              nodeContracts: nodeContracts,
              rentContracts: rentContracts),
          contractBillReports: contractBillReports);

      if (contractBillReports.isEmpty) {
        return 0;
      } else {
        var duration = 0.0;
        final amountBilled = double.parse(contractBillReports[0].amountBilled);
        if (contractBillReports.length == 2) {
          duration = (double.parse(contractBillReports[0].timeStamp) -
                  double.parse(contractBillReports[1].timeStamp)) /
              3600; //one hour
        } else {
          var createdAt = 0.0;
          for (final contracts in [
            nodeContracts,
            nameContracts,
            rentContracts
          ]) {
            if (contracts.length == 1) {
              createdAt = double.parse(contracts[0].createdAt);
              duration =
                  (double.parse(contractBillReports[0].timeStamp) - createdAt) /
                      3600;
              break;
            }
          }
        }

        if (duration == 0.0) {
          duration = 1;
        }
        return amountBilled / duration / pow(10, 7);
      }
    } catch (err) {
      throw err;
    }
  }
}
