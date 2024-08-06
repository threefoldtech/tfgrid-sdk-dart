import 'dart:typed_data';

import 'package:polkadart/scale_codec.dart';
import 'package:tfchain_client/generated/dev/types/pallet_balances/pallet/error.dart'
    as balances;
import 'package:tfchain_client/generated/dev/types/frame_system/pallet/error.dart'
    as system;
import 'package:tfchain_client/generated/dev/types/pallet_utility/pallet/error.dart'
    as utility;
import 'package:tfchain_client/generated/dev/types/pallet_scheduler/pallet/error.dart'
    as scheduler;
import 'package:tfchain_client/generated/dev/types/substrate_validator_set/pallet/error.dart'
    as validatorSet;
import 'package:tfchain_client/generated/dev/types/pallet_session/pallet/error.dart'
    as session;
import 'package:tfchain_client/generated/dev/types/pallet_grandpa/pallet/error.dart'
    as grandpa;
import 'package:tfchain_client/generated/dev/types/pallet_tfgrid/pallet/error.dart'
    as tfgrid;
import 'package:tfchain_client/generated/dev/types/pallet_smart_contract/pallet/error.dart'
    as smartContract;

import 'package:tfchain_client/generated/dev/types/pallet_tft_bridge/pallet/error.dart'
    as tftBridge;
import 'package:tfchain_client/generated/dev/types/pallet_tft_price/pallet/error.dart'
    as tftPrice;
import 'package:tfchain_client/generated/dev/types/pallet_burning/pallet/error.dart'
    as burning;
import 'package:tfchain_client/generated/dev/types/pallet_kvstore/pallet/error.dart'
    as kvstore;
import 'package:tfchain_client/generated/dev/types/pallet_collective/pallet/error.dart'
    as council;
import 'package:tfchain_client/generated/dev/types/pallet_membership/pallet/error.dart'
    as membership;
import 'package:tfchain_client/generated/dev/types/pallet_dao/pallet/error.dart'
    as dao;

import 'package:tfchain_client/generated/dev/types/pallet_validator/pallet/error.dart'
    as validator;

class Errors {
  final int moduleIndex;
  final Uint8List errorIndex;

  Errors({required this.moduleIndex, required this.errorIndex});

  _findModule() {
    switch (moduleIndex) {
      case 0:
        return system.$ErrorCodec();
      case 3:
        return utility.$ErrorCodec();
      case 4:
        return scheduler.$ErrorCodec();
      case 10:
        return validatorSet.$ErrorCodec();
      case 11:
        return session.$ErrorCodec();
      case 13:
        return grandpa.$ErrorCodec();
      case 20:
        return balances.$ErrorCodec();
      case 25:
        return tfgrid.$ErrorCodec();
      case 26:
        return smartContract.$ErrorCodec();
      case 27:
        return tftBridge.$ErrorCodec();
      case 28:
        return tftPrice.$ErrorCodec();
      case 29:
        return burning.$ErrorCodec();
      case 30:
        return kvstore.$ErrorCodec();
      case 40:
        return council.$ErrorCodec();
      case 41:
        return membership.$ErrorCodec();
      case 43:
        return dao.$ErrorCodec();
      case 50:
        return validator.$ErrorCodec();
      default:
        throw Exception(
            'Error: Invalid module index. module: "$moduleIndex", error: "$errorIndex"');
    }
  }

  decode() {
    final module = _findModule();
    try {
      final x = module.decode(Input.fromBytes(errorIndex));
      return x.variantName;
    } catch (e) {
      throw Exception(
          'Error: Invalid error index. module: "$moduleIndex", error: "$errorIndex"');
    }
  }
}
