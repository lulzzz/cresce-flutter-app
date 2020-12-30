import 'package:cresce_flutter_app/features/employees/employees.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/core/services_locator.dart';

class EmployeesModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory<EmployeeServices>(() {
      return EmployeeServices(locator.get<HttpGet>());
    });
  }
}
