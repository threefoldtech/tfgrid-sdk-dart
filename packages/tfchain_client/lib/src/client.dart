part of '../tfchain_client.dart';

class QueryClient {
  final String url;
  late final Provider api;

  QueryClient(this.url) {
    api = newProvider();
  }

  Provider newProvider() {
    return Provider.fromUri(Uri.parse(url));
    // TODO: Disconnect
  }
}
