import 'dart:mirrors';

import 'package:gridproxy_client/models/nodes.dart';
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

T fromJson<T>(Map<String, dynamic> json) {
  print('Starting deserialization for type: $T');
  print('Input JSON: $json');
  // print(json);
  ClassMirror classMirror = reflector.reflectType(T) as ClassMirror;
  print('ClassMirror: $classMirror');

  Map<Symbol, dynamic> namedParams = {};

  classMirror.declarations.forEach((symbol, declaration) {
    if (declaration is VariableMirror && !declaration.isStatic) {
      final fieldName = MirrorSystem.getName(Symbol(symbol));
      print('Processing field: $fieldName');

      var fieldValue = json.containsKey(fieldName)
          ? json[fieldName]
          : _getDefaultValue(declaration.reflectedType);

      print('Field value for $fieldName: $fieldValue');

      namedParams[Symbol(symbol)] = fieldValue;
    }
  });
  print('Named parameters: $namedParams');

  T instance = classMirror.newInstance('', [], namedParams) as T;
  print('Created instance: $instance');

  return instance;
}

dynamic _getDefaultValue(Type type) {
  if (type == int) return 0;
  if (type == double) return 0.0;
  if (type == String) return '';
  if (type == bool) return false;
  if (type == List) return [];
  if (type is ClassMirror) {
    print("HELLLOOOOO");
    print(type);
  }
  return null;
}
