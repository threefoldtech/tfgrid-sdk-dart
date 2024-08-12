import 'package:gridproxy_client/gridproxy_client.dart';
import 'package:gridproxy_client/models/stats.dart';
import 'package:http/http.dart';

class Stats {
  final GridProxyClient client;

  Stats(this.client);

  Future<StatsInfo> getStats(StatsQueryParams options) async {
    final response = await client.getRequest('stats', options.toMap());
    StatsInfo stat = StatsInfo.fromJson(response as Map<String, dynamic>);
    return stat;
  }
}
