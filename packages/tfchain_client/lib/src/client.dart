part of '../tfchain_client.dart';
// TODO: Disconnect

class QueryClient {
  final String url;
  late final Provider provider;
  late final polkadot.Dev api;
  late QueryContracts contracts;

  QueryClient(this.url) {
    newProvider();
    contracts = QueryContracts(this);
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
}
