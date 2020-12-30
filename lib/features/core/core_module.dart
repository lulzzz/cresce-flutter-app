import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/core/services_locator.dart';

class CoreModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerSingleton(NavigationManager());
  }
}
