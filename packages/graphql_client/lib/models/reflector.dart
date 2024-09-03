import 'package:reflectable/reflectable.dart';

class Reflector extends Reflectable {
  const Reflector()
      : super(
          invokingCapability,
          declarationsCapability,
          typeCapability,
          reflectedTypeCapability,
          newInstanceCapability,
          metadataCapability,
          subtypeQuantifyCapability,
          typeRelationsCapability,
        );
}

const reflector = Reflector();
