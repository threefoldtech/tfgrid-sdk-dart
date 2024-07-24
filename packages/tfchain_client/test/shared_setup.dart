import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';

import 'package:bip39/bip39.dart' as bip39;
import 'package:test/test.dart';
import 'package:tfchain_client/tfchain_client.dart';

late Client client;
late String mnemonic;
late String url;
late String type;
late String myAddress;
BigInt myBalance = BigInt.from(5000);
late int? twinId;
late String relay;

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

void sharedSetup() {
  setUpAll(() async {
    url = Platform.environment['URL'] ?? 'ws://0.0.0.0:9944';
    type = Platform.environment['KEYPAIR_TYPE'] ?? 'sr25519';
    relay = "relay.dev.grid.tf";

    mnemonic = bip39.generateMnemonic();
    client = Client(url, mnemonic, type);
    await client.connect();

    myAddress = client.address;

    Client client2 = Client(url, "//Alice", type);
    await client2.connect();

    await client2.balances.transfer(address: client.address, amount: myBalance);
    final balance = await client.balances.getMyBalance();
    expect(myBalance, balance!.data.free ~/ BigInt.from(10).pow(7));

    var bytes = utf8.encode("https://library.threefold.me/info/legal/");
    var digest = md5.convert(bytes);
    var hashString = digest.bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();

    await client.termsAndConditions.accept(
        documentLink: "https://library.threefold.me/info/legal/",
        documentHash: hashString.codeUnits);

    twinId = await client.twins.create(relay: relay, pk: []);
    print(twinId);
  });

  tearDownAll(() async {
    await client.disconnect();
  });
}
