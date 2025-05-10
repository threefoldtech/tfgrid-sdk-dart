// ignore_for_file: no_leading_underscores_for_library_prefixes
import '../types/pallet_runtime_upgrade/pallet/call.dart' as _i2;
import '../types/tfchain_runtime/runtime_call.dart' as _i1;

class Txs {
  const Txs();

  /// See [`Pallet::set_code`].
  _i1.RuntimeUpgrade setCode({required List<int> code}) {
    return _i1.RuntimeUpgrade(_i2.SetCode(code: code));
  }
}
