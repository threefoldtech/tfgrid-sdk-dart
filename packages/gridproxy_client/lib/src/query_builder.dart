import 'dart:mirrors';

import 'package:gridproxy_client/models/reflector.dart';
import 'package:reflectable/reflectable.dart';

Map<String, dynamic> toMap(Object object) {
  final instanceMirror = reflector.reflect(object);
  final classMirror = instanceMirror.type;

  final map = <String, dynamic>{};
  for (var declaration in classMirror.declarations.values) {
    if (declaration is VariableMirror && !declaration.isStatic) {
      final fieldName = MirrorSystem.getName(Symbol(declaration.simpleName));
      final fieldValue = instanceMirror.invokeGetter(declaration.simpleName);
      if (fieldValue != null) {
        map[fieldName] = fieldValue;
      }
    }
  }
  return map;
}
