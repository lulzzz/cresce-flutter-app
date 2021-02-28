import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/customers/services/customers_services.dart';

class CustomersModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory<CustomerServices>(() {
      return CustomerServices(
        locator.get<HttpGet>(),
      );
    });
  }
}
