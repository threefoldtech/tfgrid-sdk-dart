import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:tfchain_client/tfchain_client.dart';

String generateRandomString(int length) {
  const characters = 'abcdefghijklmnopqrstuvwxyz';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ),
  );
}

String getIpFromInt32Value(int value) {
  return InternetAddress.fromRawAddress(
    (ByteData(4)..setInt32(0, value, Endian.host)).buffer.asUint8List(),
  ).address;
}

int getInt32FromIp(String ip) {
  final segments = ip.split('.').map(int.parse).toList();
  return (segments[0] << 24) |
      (segments[1] << 16) |
      (segments[2] << 8) |
      segments[3];
}

bool isAllowedPublicIp(String ip) {
  final segments = ip.split('.').map(int.parse).toList();
  final int ipValue = getInt32FromIp(ip);

  return (ipValue >= getInt32FromIp("1.0.0.0") &&
          ipValue <= getInt32FromIp("9.255.255.255")) ||
      (ipValue >= getInt32FromIp("11.0.0.0") &&
          ipValue <= getInt32FromIp("126.255.255.255")) ||
      (ipValue >= getInt32FromIp("129.0.0.0") &&
          ipValue <= getInt32FromIp("169.253.255.255")) ||
      (ipValue >= getInt32FromIp("169.255.0.0") &&
          ipValue <= getInt32FromIp("172.15.255.255")) ||
      (ipValue >= getInt32FromIp("172.32.0.0") &&
          ipValue <= getInt32FromIp("191.0.1.255")) ||
      (ipValue >= getInt32FromIp("192.0.3.0") &&
          ipValue <= getInt32FromIp("192.88.98.255")) ||
      (ipValue >= getInt32FromIp("192.88.100.0") &&
          ipValue <= getInt32FromIp("192.167.255.255")) ||
      (ipValue >= getInt32FromIp("192.169.0.0") &&
          ipValue <= getInt32FromIp("198.17.255.255")) ||
      (ipValue >= getInt32FromIp("198.20.0.0") &&
          ipValue <= getInt32FromIp("223.255.255.255"));
}

String generateRandomPublicIPv4() {
  final random = Random();
  String ip;
  do {
    final value = random.nextInt(0xFFFFFFFF);
    ip = getIpFromInt32Value(value);
  } while (!isAllowedPublicIp(ip));
  return ip;
}

String generateRandomCIDRIPv4() {
  final ip = generateRandomPublicIPv4();
  return '$ip/24';
}

String generateGatewayIPv4FromIp(String ip) {
  final segments = ip.split('.').map(int.parse).toList();
  final random = Random();
  int newLastOctet;
  do {
    newLastOctet = random.nextInt(255);
  } while (newLastOctet == segments[3]);
  segments[3] = newLastOctet;
  return segments.join('.');
}

class SetupManager {
  static final SetupManager _instance = SetupManager._internal();

  factory SetupManager() {
    return _instance;
  }

  SetupManager._internal();

  late Client _client;
  late QueryClient _queryClient;
  late String _mnemonic;
  late String _url;
  late String _type;
  late String _myAddress;
  BigInt myBalance = BigInt.from(5000);
  late int? _twinId;
  late String _relay;
  late Client _client2;

  bool _initializeClient = false;
  bool _initializeQueryClient = false;

  String get url => _url;
  Client get client => _client;
  QueryClient get queryClient => _queryClient;
  String get mnemonic => _mnemonic;
  String get type => _type;
  String get myAddress => _myAddress;
  int? get twinId => _twinId;
  String get relay => _relay;

  void setInitializationFlags({bool client = false, bool queryClient = false}) {
    _initializeClient = client;
    _initializeQueryClient = queryClient;
  }

  Future<void> setup() async {
    _url = Platform.environment['URL'] ?? 'ws://0.0.0.0:9944';
    _type = Platform.environment['KEYPAIR_TYPE'] ?? 'sr25519';
    _relay = "relay.dev.grid.tf";

    if (_initializeClient) {
      _mnemonic = bip39.generateMnemonic();
      _client = Client(_url, _mnemonic, _type);
      await _client.connect();

      _myAddress = _client.address;

      _client2 = Client(_url, "//Alice", _type);
      await _client2.connect();

      await Future.delayed(Duration(seconds: 20));

      try {
        await _client2.balances
            .transfer(address: _client.address, amount: myBalance);
      } catch (error) {
        print("ERROR FROM SETUP MANAGER: $error");
      }
      final balance = await _client.balances.getMyBalance();

      var bytes = utf8.encode("https://library.threefold.me/info/legal/");
      var digest = md5.convert(bytes);
      var hashString = digest.bytes
          .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
          .join();

      await _client.termsAndConditions.accept(
          documentLink: "https://library.threefold.me/info/legal/",
          documentHash: hashString.codeUnits);
      _twinId = await _client.twins.create(relay: _relay, pk: []);
      print(_twinId);
    }

    if (_initializeQueryClient) {
      _queryClient = QueryClient(_url);
      await _queryClient.connect();
    }
  }

  Future<void> teardownAll() async {
    if (_initializeClient && _client != Null) {
      await _client.disconnect();
    }

    if (_initializeQueryClient && _queryClient != Null) {
      await _queryClient.disconnect();
    }
  }
}
