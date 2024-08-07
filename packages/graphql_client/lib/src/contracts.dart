import 'dart:math';

import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models.dart';
import 'package:graphql_client/models/contract_state.dart';

class TFContracts {
  final GraphQLClient gqlClient;

  TFContracts(this.gqlClient);

  Future<List<GqlNameContract>> listNameContractsByTwinId(
      int twinID,
      List<ContractStates> contractStates,
      GqlNameContractReturnOptions? returnOptions) async {
    final state = '[${contractStates.map((e) => e.value).join(', ')}]';
    final opts = '(where: {twinID_eq: $twinID, state_in: $state})';
    final String returnString;

    if (returnOptions == null || areAllBooleansFalse(returnOptions)) {
      returnString = '''
      id
      gridVersion
      contractID
      twinID
      state
      createdAt
      solutionProviderID
      name
      ''';
    } else {
      returnString = returnOptions.toString();
    }

    final body = '''
    query getNameContracts {
      nameContracts $opts {
        $returnString
      }
    }''';

    final response = await gqlClient.query(body);

    if (response['data'] == null) {
      throw Exception("Data returned is null");
    }
    if (response['data']['nameContracts'] == null) {
      throw Exception("NameContracts returned is null");
    }
    final nameContractsDataList =
        response['data']['nameContracts'] as List<dynamic>;
    if (nameContractsDataList.any((item) => item is! Map<String, dynamic>)) {
      throw Exception(
          'Invalid data format: Expected a list of maps: $response');
    }

    List<GqlNameContract> nameContracts = nameContractsDataList.map((data) {
      return GqlNameContract.fromJson(data);
    }).toList();

    return nameContracts;
  }

  Future<List<GqlRentContract>> listRentContractsByTwinId(
      int twinID,
      List<ContractStates> contractStates,
      GqlRentContractReturnOptions? returnOptions) async {
    final state = '[${contractStates.map((e) => e.value).join(', ')}]';
    final opts = '(where: {twinID_eq: $twinID, state_in: $state})';
    final String returnString;

    if (returnOptions == null || areAllBooleansFalse(returnOptions)) {
      returnString = '''
      id
      gridVersion
      contractID
      twinID
      state
      createdAt
      solutionProviderID
      nodeID
      ''';
    } else {
      returnString = returnOptions.toString();
    }

    final body = '''
    query getRentContracts {
      rentContracts $opts {
        $returnString
      }
    }''';

    final response = await gqlClient.query(body);

    if (response['data'] == null) {
      throw Exception("Data returned is null");
    }
    if (response['data']['rentContracts'] == null) {
      throw Exception("RentContracts returned is null");
    }
    final rentContractsDataList =
        response['data']['rentContracts'] as List<dynamic>;
    if (rentContractsDataList.any((item) => item is! Map<String, dynamic>)) {
      throw Exception(
          'Invalid data format: Expected a list of maps: $response');
    }

    List<GqlRentContract> rentContracts = rentContractsDataList.map((data) {
      return GqlRentContract.fromJson(data);
    }).toList();

    return rentContracts;
  }

  Future<List<GqlNodeContract>> listNodeContractsByTwinId(
      int twinID,
      List<ContractStates> contractStates,
      GqlNodeContractReturnOptions? returnOptions) async {
    final state = '[${contractStates.map((e) => e.value).join(', ')}]';
    final opts = '(where: {twinID_eq: $twinID, state_in: $state})';
    final String returnString;

    if (returnOptions == null || areAllBooleansFalse(returnOptions)) {
      returnString = '''
      id
      gridVersion
      contractID
      twinID
      state
      createdAt
      nodeID
      numberOfPublicIPs
      solutionProviderID
      deploymentData
      deploymentHash
      resourcesUsed {
        cru
        hru
        id
        mru
        sru
      }
      ''';
    } else {
      returnString = returnOptions.toString();
    }

    final body = '''
    query getNodeContracts {
      nodeContracts $opts {
        $returnString
      }
    }''';

    final response = await gqlClient.query(body);

    if (response['data'] == null) {
      throw Exception("Data returned is null");
    }
    if (response['data']['nodeContracts'] == null) {
      throw Exception("NodeContracts returned is null");
    }
    final nodeContractsDataList =
        response['data']['nodeContracts'] as List<dynamic>;
    if (nodeContractsDataList.any((item) => item is! Map<String, dynamic>)) {
      throw Exception(
          'Invalid data format: Expected a list of maps: $response');
    }

    List<GqlNodeContract> nodeContracts = nodeContractsDataList.map((data) {
      return GqlNodeContract.fromJson(data);
    }).toList();

    return nodeContracts;
  }

  Future<List<GqlContractBillReports>> listContractConsumption(
      BigInt contractId,
      GqlContractBillReportsReturnOptions? returnOptions) async {
    final String returnString;

    if (returnOptions == null || areAllBooleansFalse(returnOptions)) {
      returnString = '''
    contractID
    amountBilled
    discountReceived
    timestamp
    id
    ''';
    } else {
      returnString = returnOptions.toString();
    }

    final body = '''
        query getConsumptionforNameContracts {
          contractBillReports(where : {contractID_eq: $contractId}){
            $returnString
          }
        }

      ''';

    final response = await gqlClient.query(body);

    if (response['data'] == null) {
      throw Exception("Data returned is null");
    }

    if (response['data']['contractBillReports'] == null) {
      throw Exception("contractBillReports returned is null");
    }

    final contractBillReportsDataList =
        response['data']['contractBillReports'] as List<dynamic>;
    if (contractBillReportsDataList
        .any((item) => item is! Map<String, dynamic>)) {
      throw Exception(
          'Invalid data format: Expected a list of maps: $response');
    }

    List<GqlContractBillReports> contractBillReports =
        contractBillReportsDataList.map((data) {
      return GqlContractBillReports.fromJson(data);
    }).toList();

    return contractBillReports;
  }

  Future<GqlContracts> listContractsByTwinId(
      ListContractByTwinIdOptions options) async {
    options.stateList ??= [
      ContractStates.Created.value,
      ContractStates.GracePeriod.value
    ];

    final state = '[${options.stateList!.join(', ')}]';

    final opts = '(where: {twinID_eq: ${options.twinId}, state_in: $state})';
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
        return GqlNameContract.fromJson(contractData);
      }).toList();

      List<GqlNodeContract> nodeContracts =
          (response['data']['nodeContracts'] as List<dynamic>)
              .map((contractData) {
        return GqlNodeContract.fromJson(contractData);
      }).toList();

      List<GqlRentContract> rentContracts =
          (response['data']['rentContracts'] as List<dynamic>)
              .map((contractData) {
        return GqlRentContract.fromJson(contractData);
      }).toList();

      return GqlContracts(
          nameContracts: nameContracts,
          nodeContracts: nodeContracts,
          rentContracts: rentContracts);
    } catch (err) {
      throw err;
    }
  }

  //Future<double> getConsumption(GetConsumptionOptions options) async {
//     final body = '''
// query getConsumption(\$contractId: BigInt!) {
//   contractBillReports(where: {contractID_eq: \$contractId}, limit: 2, orderBy: timestamp_DESC) {
//     amountBilled
//     timestamp
//     discountReceived
//   }
//   nameContracts(where: {contractID_eq: \$contractId}) {
//     contractID
//     createdAt
//     name
//     solutionProviderID
//     state
//     twinID
//   }
//   nodeContracts(where: {contractID_eq: \$contractId}) {
//     contractID
//     deploymentData
//     state
//     createdAt
//     nodeID
//     numberOfPublicIPs
//   }
//   rentContracts(where: {contractID_eq: \$contractId}) {
//     contractID
//     createdAt
//     nodeID
//     solutionProviderID
//     state
//     twinID
//   }
// }
// ''';

//     try {
//       final response = await gqlClient.query(body, variables: {
//         'contractId': options.contractID,
//       });

//       List<dynamic> contractBillReportsData =
//           response['data']['contractBillReports'];
//       List<dynamic> nodeContractsData = response['data']['nodeContracts'];
//       List<dynamic> nameContractsData = response['data']['nameContracts'];
//       List<dynamic> rentContractsData = response['data']['rentContracts'];

//       List<GqlContractBillReports> contractBillReports =
//           contractBillReportsData.map((data) {
//         return GqlContractBillReports.fromJson(data);
//       }).toList();

//       List<GqlNodeContract> nodeContracts = nodeContractsData.map((data) {
//         return GqlNodeContract.fromJson(data);
//       }).toList();

//       List<GqlNameContract> nameContracts = nameContractsData.map((data) {
//         return GqlNameContract.fromJson(data);
//       }).toList();

//       List<GqlRentContract> rentContracts = rentContractsData.map((data) {
//         return GqlRentContract.fromJson(data);
//       }).toList();

//       GqlConsumption gqlConsumption = GqlConsumption(
//           contracts: GqlContracts(
//               nameContracts: nameContracts,
//               nodeContracts: nodeContracts,
//               rentContracts: rentContracts),
//           contractBillReports: contractBillReports);

//       if (contractBillReports.isEmpty) {
//         return 0;
//       } else {
//         var duration = 0.0;
//         final amountBilled = double.parse(contractBillReports[0].amountBilled);
//         if (contractBillReports.length == 2) {
//           duration = (double.parse(contractBillReports[0].timeStamp) -
//                   double.parse(contractBillReports[1].timeStamp)) /
//               3600; //one hour
//         } else {
//           var createdAt = 0.0;
//           for (final contracts in [
//             nodeContracts,
//             nameContracts,
//             rentContracts
//           ]) {
//             if (contracts.length == 1) {
//               createdAt = double.parse(contracts[0].createdAt);
//               duration =
//                   (double.parse(contractBillReports[0].timeStamp) - createdAt) /
//                       3600;
//               break;
//             }
//           }
//         }

//         if (duration == 0.0) {
//           duration = 1;
//         }
//         return amountBilled / duration / pow(10, 7);
//       }
//     } catch (err) {
//       throw err;
//     }
//   }
}
