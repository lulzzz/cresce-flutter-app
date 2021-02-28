import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/pages/pages.dart';

class PageWidgetsModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerSingleton(EmployeePageWidget());
    locator.registerSingleton(LoginPageWidget());
    locator.registerSingleton(MainPageWidget());
  }
}
