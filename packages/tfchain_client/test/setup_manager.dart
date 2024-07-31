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

bool isPublicIp(String ip) {
  final segments = ip.split('.').map(int.parse).toList();
  if (segments[0] == 10 ||
      (segments[0] == 172 && segments[1] >= 16 && segments[1] <= 31) ||
      (segments[0] == 192 && segments[1] == 168) ||
      segments[0] == 127 ||
      (segments[0] == 169 && segments[1] == 254)) {
    return false;
  }
  return true;
}

String generateRandomPublicIPv4() {
  final random = Random();
  String ip;
  do {
    final value = random.nextInt(0xFFFFFFFF);
    ip = getIpFromInt32Value(value);
  } while (!isPublicIp(ip));
  return ip;
}

String generateRandomCIDRIPv4() {
  final ip = generateRandomPublicIPv4();
  final subnet = Random().nextInt(16) + 16;
  return '$ip/$subnet';
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
  late String _mnemonic;
  late String _url;
  late String _type;
  late String _myAddress;
  BigInt myBalance = BigInt.from(5000);
  late int? _twinId;
  late String _relay;

  String get url => _url;
  Client get client => _client;
  String get mnemonic => _mnemonic;
  String get type => _type;
  String get myAddress => _myAddress;
  int? get twinId => _twinId;
  String get relay => _relay;

  Future<void> setup() async {
    _url = Platform.environment['URL'] ?? 'ws://0.0.0.0:9944';
    _type = Platform.environment['KEYPAIR_TYPE'] ?? 'sr25519';
    _relay = "relay.dev.grid.tf";

    _mnemonic = bip39.generateMnemonic();
    _client = Client(_url, _mnemonic, _type);
    await _client.connect();

    _myAddress = _client.address;

    Client client2 = Client(_url, "//Alice", _type);
    await client2.connect();

    await client2.balances
        .transfer(address: _client.address, amount: myBalance);
    final balance = await client2.balances.getMyBalance();
    print("My Balance : ${balance!.data.free ~/ BigInt.from(10).pow(7)}");

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

  Future<void> teardownAll() async {
    await client.disconnect();
  }
}
