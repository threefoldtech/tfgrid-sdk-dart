library globals;

import 'setup_manager.dart';

SetupManager? _globalSetupManager;

Future<SetupManager> getSetupManager() async {
  if (_globalSetupManager != null && SetupManager.isInitialized) {
    print("_setupManager.isInitialized ${SetupManager.isInitialized}");
    return _globalSetupManager!;
  }

  _globalSetupManager = SetupManager();
  _globalSetupManager!.setInitializationFlags(queryClient: true, client: true);
  await _globalSetupManager!.setup();
  SetupManager.isInitialized = true;
  return _globalSetupManager!;
}
