enum ContractStates {
  Created,
  Deleted,
  OutOfFunds,
  GracePeriod,
}

extension ContractStatesExtension on ContractStates {
  String get value {
    switch (this) {
      case ContractStates.Created:
        return 'Created';
      case ContractStates.Deleted:
        return 'Deleted';
      case ContractStates.OutOfFunds:
        return 'OutOfFunds';
      case ContractStates.GracePeriod:
        return 'GracePeriod';
      default:
        throw Exception('Invalid ContractState');
    }
  }
}
