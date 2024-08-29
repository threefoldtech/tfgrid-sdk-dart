part of '../stellar_client.dart';

enum NetworkType {
  TESTNET,
  PUBLIC;

  @override
  String toString() {
    switch (this) {
      case NetworkType.TESTNET:
        return 'TESTNET';
      case NetworkType.PUBLIC:
        return 'PUBLIC';
    }
  }
}
