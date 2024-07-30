import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models/farms.dart';
import 'package:graphql_client/models/public_ips.dart';

class TFFarms {
  final GraphQLClient gqlClient;

  TFFarms(this.gqlClient);

  Future<List<FarmInfo>> listFarms(FarmsQueryOptions? queryOptions,
      FarmsReturnOptions? returnOptions) async {
    final queryString = queryOptions?.toString() ?? "";
    final returnString = returnOptions?.toString() ?? "id \n";

    final body = '''
            query Farms{
              farms $queryString {
                $returnString
              }
            }''';

    print(body);

    try {
      final response = await gqlClient.query(body);
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
          publicIps: farmsData['publicIps'] != null
              ? PublicIpsInfo.fromJson(farmsData['publicIps'])
              : null,
        );
      }).toList();
      return farms;
    } catch (err) {
      throw err;
    }
  }
}
