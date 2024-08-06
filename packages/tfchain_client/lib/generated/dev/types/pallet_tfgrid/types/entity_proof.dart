// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

class EntityProof {
  const EntityProof({
    required this.entityId,
    required this.signature,
  });

  factory EntityProof.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int entityId;

  /// Vec<u8>
  final List<int> signature;

  static const $EntityProofCodec codec = $EntityProofCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'entityId': entityId,
        'signature': signature,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is EntityProof &&
          other.entityId == entityId &&
          _i3.listsEqual(
            other.signature,
            signature,
          );

  @override
  int get hashCode => Object.hash(
        entityId,
        signature,
      );
}

class $EntityProofCodec with _i1.Codec<EntityProof> {
  const $EntityProofCodec();

  @override
  void encodeTo(
    EntityProof obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.entityId,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.signature,
      output,
    );
  }

  @override
  EntityProof decode(_i1.Input input) {
    return EntityProof(
      entityId: _i1.U32Codec.codec.decode(input),
      signature: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(EntityProof obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.entityId);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.signature);
    return size;
  }
}
