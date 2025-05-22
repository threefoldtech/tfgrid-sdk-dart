part of '../gridproxy_client.dart';

class GridProxyClient {
  final String baseUrl;
  late final Nodes nodes;
  late final Contracts contracts;
  late final Farms farms;
  late final Stats stats;
  late final Twins twins;

  GridProxyClient(this.baseUrl) {
    nodes = Nodes(this);
    contracts = Contracts(this);
    farms = Farms(this);
    stats = Stats(this);
    twins = Twins(this);
  }

  Future<dynamic> getRequest(
      String path, Map<String, dynamic>? queryParameters) async {
    try {
      final Map<String, String> encodedQueryParams = {};
      queryParameters?.forEach((key, value) {
        if (value is List) {
          encodedQueryParams[key] = value.map((e) => e.toString()).join(',');
        } else if (value != null) {
          encodedQueryParams[key] = value.toString();
        }
      });

      final uri = Uri.parse(baseUrl);
      final scheme = uri.scheme;
      final host = uri.host;

      final requestUri = encodedQueryParams.isNotEmpty
          ? (scheme == 'https'
              ? Uri.https(host, path, encodedQueryParams)
              : Uri.http(host, path, encodedQueryParams))
          : (scheme == 'https' ? Uri.https(host, path) : Uri.http(host, path));

      final response = await http.get(requestUri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData;
      } else {
        throw Exception(
            'Failed to load data. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during GET request to $path: $e');
    }
  }
}
