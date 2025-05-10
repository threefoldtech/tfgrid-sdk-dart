// ignore_for_file: no_leading_underscores_for_library_prefixes
import '../types/pallet_utility/pallet/call.dart' as _i2;
import '../types/sp_weights/weight_v2/weight.dart' as _i4;
import '../types/tfchain_runtime/origin_caller.dart' as _i3;
import '../types/tfchain_runtime/runtime_call.dart' as _i1;

class Txs {
  const Txs();

  /// See [`Pallet::batch`].
  _i1.Utility batch({required List<_i1.RuntimeCall> calls}) {
    return _i1.Utility(_i2.Batch(calls: calls));
  }

  /// See [`Pallet::as_derivative`].
  _i1.Utility asDerivative({
    required int index,
    required _i1.RuntimeCall call,
  }) {
    return _i1.Utility(_i2.AsDerivative(
      index: index,
      call: call,
    ));
  }

  /// See [`Pallet::batch_all`].
  _i1.Utility batchAll({required List<_i1.RuntimeCall> calls}) {
    return _i1.Utility(_i2.BatchAll(calls: calls));
  }

  /// See [`Pallet::dispatch_as`].
  _i1.Utility dispatchAs({
    required _i3.OriginCaller asOrigin,
    required _i1.RuntimeCall call,
  }) {
    return _i1.Utility(_i2.DispatchAs(
      asOrigin: asOrigin,
      call: call,
    ));
  }

  /// See [`Pallet::force_batch`].
  _i1.Utility forceBatch({required List<_i1.RuntimeCall> calls}) {
    return _i1.Utility(_i2.ForceBatch(calls: calls));
  }

  /// See [`Pallet::with_weight`].
  _i1.Utility withWeight({
    required _i1.RuntimeCall call,
    required _i4.Weight weight,
  }) {
    return _i1.Utility(_i2.WithWeight(
      call: call,
      weight: weight,
    ));
  }
}

class Constants {
  Constants();

  /// The limit on the number of batched calls.
  final int batchedCallsLimit = 10922;
}
