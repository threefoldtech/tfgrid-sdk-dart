import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_client/models/twins.dart';

class TFTwins {
  final GraphQLClient gqlClient;

  TFTwins(this.gqlClient);

  Future<List<TwinInfo>> Twins(
      TwinReturnOptions? returnOptions , TwinQueryOptions? queryOptions) async {
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
          List<TwinInfo> twins = (response['data']['twins'] as List<dynamic>).map((twinsData) {
  return TwinInfo.fromJson(twinsData as Map<String, dynamic>);
}).toList();
      
      print(twins);
      return twins;
    } catch (err) {
      throw err;
    }
  }


 Future<TwinConnectionsInfo> TwinsConnections(
      TwinConnectionsReturnOptions? returnOptions , TwinConnectionsQueryOptions? queryOptions) async {
      final queryString = queryOptions?.toString() ?? "";
      final returnString = returnOptions?.toString();
    final body = '''
query Twins {
  twinsConnection $queryString {
    $returnString
  }
}''';
    try {
    print(body);
      final response =
          await gqlClient.query(body);
    TwinConnectionsInfo twinsConnection=  TwinConnectionsInfo.fromJson(response['data']['twinsConnection'] as Map<String, dynamic>); 
    print(twinsConnection);
    return twinsConnection;
    } catch (err) {
      throw err;
    }
  }
}

