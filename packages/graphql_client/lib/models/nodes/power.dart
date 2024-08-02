part of '../../models.dart';

enum PowerState {
  Up,
  Down,
}

enum Power {
  Up,
  Down,
}

Power powerFromJson(String jsonString) {
  switch (jsonString) {
    case 'Up':
      return Power.Up;
    case 'Down':
    default:
      return Power.Down;
  }
}

PowerState powerStateFromJson(String jsonString) {
  switch (jsonString) {
    case 'Up':
      return PowerState.Up;
    case 'Down':
    default:
      return PowerState.Down;
  }
}

class NodePowerReturnOptions {
  bool state;
  bool target;

  NodePowerReturnOptions({
    this.state = false,
    this.target = false,
  });
  @override
  String toString() {
    String returnOptions = "";
    if (!state && !target) state = true;
    returnOptions = _addToReturnList(returnOptions, "state", state);
    returnOptions = _addToReturnList(returnOptions, "target", target);
    if (returnOptions != "") returnOptions = "power { \n $returnOptions } \n";
    return returnOptions;
  }
}

class NodePower {
  PowerState? state;
  Power? target;

  NodePower({
    this.state,
    this.target,
  });

  factory NodePower.fromJson(Map<String, dynamic> json) {
    return NodePower(
      state: json['state'] != null ? powerStateFromJson(json['state']) : null,
      target: json['target'] != null ? powerFromJson(json['target']) : null,
    );
  }

  @override
  String toString() {
    return 'NodePower(state: $state, target: $target)';
  }
}
