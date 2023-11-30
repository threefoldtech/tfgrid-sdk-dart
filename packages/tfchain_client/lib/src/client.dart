part of '../tfchain_client.dart';

class QueryClient {
  final String url;
  late final Provider provider;
  late final polkadot.Dev api;
  late QueryContracts contracts;
  late QueryBalances balances;
  late QueryFarms farms;
  late QueryNodes nodes;
  late QueryPricingPolicies policies;
  late QueryTwins twins;

  QueryClient(this.url) {
    newProvider();
    contracts = QueryContracts(this);
    balances = QueryBalances(this);
    farms = QueryFarms(this);
    nodes = QueryNodes(this);
    policies = QueryPricingPolicies(this);
    twins = QueryTwins(this);
  }

  void newProvider() {
    final provider = Provider.fromUri(Uri.parse(url));
    api = polkadot.Dev(provider);
  }

  void checkInputs() {
    if (url.isEmpty) {
      throw Exception("url should be provided");
    }
  }

  void connect() async {
    checkInputs();
  }

  void disconnect() async {
    await api.disconnect();
  }
}
