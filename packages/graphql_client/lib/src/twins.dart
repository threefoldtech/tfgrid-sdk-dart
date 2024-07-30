import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models/twins.dart';

class TFTwins {
  final GraphQLClient gqlClient;

  TFTwins(this.gqlClient);

  Future<List<TwinInfo>> Twins(
      TwinReturnOptions? returnOptions , TwinQueryOption? queryOptions) async {
      final queryString = queryOptions?.toString() ?? "";
      final returnString = returnOptions?.toString() ?? "id \n";
    final body = '''
query Twins {
  twins $queryString {
    $returnString
  }
}''';
print(body);
    try {
      final response =
          await gqlClient.query(body);
      List<TwinInfo> twins =
          (response['data']['twins'] as List<dynamic>).map((twinsData) {
        return TwinInfo(
          id: twinsData['id'] ?? '',
          accountID: twinsData['accountID'] ?? '',
          gridVersion: twinsData['gridVersion'] ?? 0,
          publicKey: twinsData['publicKey'] ?? '',
          relay: twinsData['relay'] ?? '',
          twinID: twinsData['twinID'] ?? 0,
        );
      }).toList();
      print(twins);
      return twins;
    } catch (err) {
      throw err;
    }
  }
}

