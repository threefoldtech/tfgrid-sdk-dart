import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:bip39/bip39.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart';
import 'package:fixnum/fixnum.dart';
import 'package:pointycastle/export.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:rmb_client/rmb_client.dart';
import 'package:rmb_client/src/sign.dart';
import 'package:rmb_client/src/utils.dart';
import 'package:rmb_client/types/generated/types.pb.dart';
import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/types/entity.dart';
import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/types/twin.dart';
import 'package:tfchain_client/tfchain_client.dart'
    as TFClient; // Adjust this import based on your project structure
import 'package:crypto/crypto.dart' as Crypto;
import 'dart:convert'; // For utf8.encode
import 'package:convert/convert.dart';
import 'package:ss58/ss58.dart' as SS58;

class ClientEnvelope {
  late final Envelope envelope;
  late KeyPair signer;
  late final String chainUrl;
  Twin? twin;
  late final TFClient.QueryClient tfClient;
  late final Map<int, TwinsMap> twins;

  ClientEnvelope({
    KeyPair? signer,
    required Envelope envelope,
    required this.chainUrl,
    required this.tfClient,
    required this.twins,
  }) : envelope = envelope {
    if (signer != null) {
      this.signer = signer;
    }
    envelope.schema = "application/json";
  }

  String? get uid => envelope.uid;
  String? get tags => envelope.tags;
  Int64? get timestamp => envelope.timestamp;
  Int64? get expiration => envelope.expiration;
  Address? get source => envelope.source;
  Address? get destination => envelope.destination;
  Request? get request => envelope.request;
  Response? get response => envelope.response;
  List<int>? get signature => envelope.signature;
  String? get schema => envelope.schema;
  String? get federation => envelope.federation;
  Error? get error => envelope.error;
  List<int>? get plain => envelope.plain;
  List<int>? get cipher => envelope.cipher;
  Ping? get ping => envelope.ping;
  Pong? get pong => envelope.pong;
  List<String>? get relays => envelope.relays;

  set signature(List<int>? value) {
    envelope.signature = value!;
  }

  set plain(List<int>? value) {
    envelope.plain = value!;
  }

  set relays(List<String>? value) {
    relays = value;
  }

  Uint8List signEnvelope() {
    final toSign = challenge();
    return sign(toSign, signer);
  }

  Future<void> getSigner(KeyPairType type) async {
    try {
      // final keyring = Keyring();
      // final address = keyring.encodeAddress(twin!.accountId);
      // print("Address $address");
      // // KeyPair.sr25519.
      // //5CJrCjZvsudNoJApTGG5PKcZfhAzAyGqgSK8bysoCV2oRBMC

      // final x = SS58.Address.decode(address);

      // // signer = keyring.
      // print(signer.address);
      // print(signer.keyPairType);

      signer = await KeyPair.sr25519.fromMnemonic(
          "example athlete word glove believe result relief click local motion team any");

      sleep(Duration(seconds: 20));
      print("ADDRESS: ${signer.address}");
    } catch (e) {
      print("Error retrieving signer: $e");
    }
  }

  Uint8List createNonce(int size) {
    Random random = Random();
    List<int> randArr =
        List<int>.generate(size, (index) => (random.nextDouble() * 10).toInt());
    return Uint8List.fromList(randArr);
  }

  Uint8List challenge() {
    var sink = AccumulatorSink<Crypto.Digest>();
    var md5Hasher = md5.startChunkedConversion(sink);

    md5Hasher.add(utf8.encode(uid!));

    md5Hasher.add(utf8.encode(tags!));

    md5Hasher.add(utf8.encode('$timestamp'));

    md5Hasher.add(utf8.encode('$expiration'));

    md5Hasher.add(utf8.encode(challengeAddress(envelope.source)));

    md5Hasher.add(utf8.encode(challengeAddress(envelope.destination)));

    if (request != null) {
      md5Hasher = challengeRequest(request!, md5Hasher);
    } else if (response != null) {
      md5Hasher = challengeResponse(response!, md5Hasher);
    } else if (error != null) {
      md5Hasher = challengeError(error!, md5Hasher);
    }
    if (schema!.isNotEmpty) {
      md5Hasher.add(utf8.encode(schema!));
    }

    if (federation!.isEmpty) {
      md5Hasher.add(utf8.encode(federation!));
    }
    if (plain!.isNotEmpty) {
      final plainHex = hex.encode(plain!);
      md5Hasher.add(hex.decode(plainHex));
    } else if (cipher!.isNotEmpty) {
      final plainHex = hex.encode(cipher!);
      md5Hasher.add(hex.decode(plainHex));
    }

    if (relays!.isNotEmpty) {
      for (String relay in relays!) {
        md5Hasher.add(utf8.encode(relay));
      }
    }

    md5Hasher.close();
    Crypto.Digest updatedHash = sink.events.single;

    return Uint8List.fromList(updatedHash.bytes);
  }

  String challengeAddress(Address address) {
    return '${address.twin}${address.connection}';
  }

  ByteConversionSink challengeRequest(
      Request request, ByteConversionSink md5Hasher) {
    md5Hasher.add(utf8.encode(request.command));
    return md5Hasher;
  }

  ByteConversionSink challengeError(Error err, ByteConversionSink md5Hasher) {
    md5Hasher.add(utf8.encode('${error!.code}${error!.message}'));
    return md5Hasher;
  }

  ByteConversionSink challengeResponse(
      Response response, ByteConversionSink md5Hasher) {
    return md5Hasher;
  }

  Future<void> encrypt(
      dynamic requestData, String mnemonic, String destTwinPk) async {
    final publicKey = Uint8List.fromList(hexStringToArrayBuffer(destTwinPk));
  }

  Future<void> decrypt(String mnemonic) async {
    final publicKey = Uint8List.fromList(twin!.pk!);
    final sharedKey = await createShared(publicKey, mnemonic);
    final iv = cipher!.sublist(0, 12);
    final slicedData = cipher!.sublist(12);

    // Create AES-GCM encrypter
    final key = Key(sharedKey);
    final initializationVector = IV(Uint8List.fromList(iv));
    final decrypter = Encrypter(AES(key, mode: AESMode.gcm));
    final decrypted = decrypter.decryptBytes(
      Encrypted(Uint8List.fromList(slicedData)),
      iv: initializationVector,
    );

    final decryptedText = utf8.decode(decrypted);
    print("DECRYPTED TEXT");
    print(decryptedText);
  }

  Future<bool> verify() async {
    try {
      String sig = String.fromCharCodes(signature!);

      final prefix = sig.substring(0, 1);
      KeyPairType? sigType;

      if (prefix == 'e') {
        sigType = KeyPairType.ed25519;
      } else if (prefix == 's') {
        sigType = KeyPairType.sr25519;
      } else {
        return false;
      }

      print(sigType);

      // get twin of sender from twinid
      twin = await getTwin(source!.twin, twins, tfClient);
      print(twin!.id);
      // print(signer.address);
      await getSigner(sigType);
      // print(signer.address);
      final dataHashed = challenge();
      try {
        signer.verify(Uint8List.fromList(dataHashed),
            Uint8List.fromList(signature!.sublist(1)));
      } catch (error) {
        throw Exception(error);
      }
      return signer.verify(
          dataHashed, Uint8List.fromList(signature!.sublist(1)));
    } catch (error) {
      print("Invalid Destination Twin: $error");
      return false;
    }
  }

  Future<Uint8List> createShared(
      Uint8List pubKey, String hexSeedOrMnemonic) async {
    List<int> privateKey;

    if (hexSeedOrMnemonic.length == 66) {
      privateKey =
          Uint8List.fromList((hexSeedOrMnemonic.substring(2).codeUnits));
    } else if (hexSeedOrMnemonic.length == 64) {
      privateKey = Uint8List.fromList(hexSeedOrMnemonic.codeUnits);
    } else if (validateMnemonic(hexSeedOrMnemonic)) {
      final seed = mnemonicToSeed(hexSeedOrMnemonic);
      privateKey = seed.sublist(0, 32);
    } else {
      throw Exception(
          'Expected a valid mnemonic or hexSeed in "createShared" but got: $hexSeedOrMnemonic.');
    }

    final pointX =
        await getSharedSecret(Uint8List.fromList(privateKey), pubKey);
    final sha256Digest = SHA256Digest();
    return sha256Digest.process(Uint8List.fromList(pointX).sublist(1, 33));
  }
}
