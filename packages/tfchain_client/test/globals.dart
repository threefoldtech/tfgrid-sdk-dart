library globals;

import 'package:test/scaffolding.dart';

import 'setup_manager.dart';

final SetupManager setupManager = getSetupManager();

getSetupManager() {
  final _setupManager = new SetupManager();
  setUpAll(() async {
    _setupManager.setInitializationFlags(queryClient: true, client: true);
    await _setupManager.setup();
  });

  return _setupManager;
}
