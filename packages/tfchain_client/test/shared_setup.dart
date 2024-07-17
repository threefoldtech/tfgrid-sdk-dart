import 'dart:io';
import 'dart:math';

import 'package:test/test.dart';

late String mnemonic;
late String url;
late String type;

late String myAddress;
late String invalidAddress;
late String recipientAddress;

late BigInt deletedContract;
late BigInt invalidContractId;
late int nodeId;
late int invalidNodeId;
late String nameContract;
late int myNode;
late int rentNode;

late int farmId;
late int invalidFarmId;
late String existingFarmName;
late int myFarmId;
late String existingIPv4;
late String validIPv4;
late String gw4;
late String InvalidGateway;
late String stellarAddress;

late int pricingPolicyId;
late int invalidPricingPolicyId;

late int twinId;
late String relay;

String generateRandomString(int length) {
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ),
  );
}

void sharedSetup() {
  setUp(() {
    mnemonic = Platform.environment['MNEMONIC'] !;
    url = Platform.environment['URL'] ?? 'wss://tfchain.dev.grid.tf/ws';
    type = Platform.environment['KEYPAIR_TYPE'] ?? 'sr25519';

    myAddress = "5CJrCjZvsudNoJApTGG5PKcZfhAzAyGqgSK8bysoCV2oRBMC";
    invalidAddress = "address";
    recipientAddress = "5EcSXeEH35LriE2aWxX6v4yZSMq47vdJ1GgHEXDdhJxg9XjG";

    deletedContract = BigInt.from(97897);
    invalidContractId = BigInt.from(-200);
    nodeId = 21;
    invalidNodeId = -21;
    nameContract = "xxx";
    myNode = 140;
    rentNode = 72;

    farmId = 1;
    invalidFarmId = -50;
    existingFarmName = "hellofarm";
    myFarmId = 4588;
    existingIPv4 = "198.165.15.25/16";
    validIPv4 = "198.165.15.29/16";
    gw4 = "198.165.15.26";
    InvalidGateway = "198.165.15.29";
    stellarAddress = "GDHJP6TF3UXYXTNEZ2P36J5FH7W4BJJQ4AYYAXC66I2Q2AH5B6O6BCFG";

    pricingPolicyId = 1;
    invalidPricingPolicyId = -80;

    twinId = 214;
    relay = "relay.dev.grid.tf";
  });
}
