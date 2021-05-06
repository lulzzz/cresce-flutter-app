import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/employees/employees.dart';

class EmployeesModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory<EntityListGateway<Employee>>(() {
      return locator.get<EmployeeServices>();
    });

    locator.registerFactory<EmployeeServices>(() {
      return EmployeeServices(
        locator.get<HttpGet>(),
        locator.get<HttpPost>(),
        locator.get<TokenRepository>(),
      );
    });

    locator.registerDataLoader<Employee>();
  }
}
