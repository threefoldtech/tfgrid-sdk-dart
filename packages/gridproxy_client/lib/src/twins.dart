import 'package:gridproxy_client/gridproxy_client.dart';
import 'package:gridproxy_client/models/twins.dart';

class Twins {
  final GridProxyClient client;

  Twins(this.client);

  Future<List<TwinsInfo>> getTwins(TwinsQueryParams queryParameters) async {
    final response = await client.getRequest('/twins', queryParameters.toMap());
    List<TwinsInfo> twins = (response as List<dynamic>).map((contractsData) {
      return TwinsInfo.fromJson(contractsData as Map<String, dynamic>);
    }).toList();
    return twins;
  }

  Future<TwinConsumption> getTwinConsumption(int twinID) async {
    final response = await client.getRequest('twins/$twinID/consumption', null);
    TwinConsumption twinConsumption =
        TwinConsumption.fromJson(response as Map<String, dynamic>);
    return twinConsumption;
  }
}
