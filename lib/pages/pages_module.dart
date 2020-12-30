import 'package:cresce_flutter_app/pages/employee_page_widget.dart';
import 'package:cresce_flutter_app/features/core/services_locator.dart';

class PageWidgetsModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerSingleton<EmployeePageWidget>(EmployeePageWidget(
      title: '',
    ));
  }
}
