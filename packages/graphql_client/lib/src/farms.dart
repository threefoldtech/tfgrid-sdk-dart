import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models/farms.dart';

class TFFarms {
  final GraphQLClient gqlClient;

  TFFarms(this.gqlClient);

  Future<List<FarmInfo>> listFarmsByTwinId(
      ListFarmsByTwinIdOptions options) async {
    print(options.twinId);
    var body = '''
''';

//     final body = '''
// query getFarms(\$twinId: Int!) {
//   farms(where: {twinID_eq: \$twinId}) {
//     farmID
//     name
//     certification
//     dedicatedFarm
//     pricingPolicyID
//     stellarAddress
//     twinID
//   }
// }''';

    try {
      final response =
          await gqlClient.query(body, variables: {'twinId': options.twinId});
      print(response['data']);
      List<FarmInfo> farms =
          (response['data']['farms'] as List<dynamic>).map((farmsData) {
        return FarmInfo(
          id: farmsData['id'],
          farmID: farmsData['farmID'] ?? 0,
          certification: farmsData['certification'] ?? '',
          dedicatedFarm: farmsData['dedicatedFarm'] ?? false,
          name: farmsData['name'] ?? '',
          pricingPolicyID: farmsData['pricingPolicyID'] ?? 0,
          stellarAddress: farmsData['stellarAddress'] ?? '',
          twinID: farmsData['twinID'] ?? 0,
        );
      }).toList();
      return farms;
    } catch (err) {
      throw err;
    }
  }

  // Future<List<FarmInfo>> listFarmByUniqueInput()
}
