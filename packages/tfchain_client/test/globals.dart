library globals;

import 'setup_manager.dart';

Future<SetupManager> getSetupManager() async {
  final _setupManager = new SetupManager();
  _setupManager.setInitializationFlags(queryClient: true, client: true);
  await _setupManager.setup();

  return _setupManager;
}
