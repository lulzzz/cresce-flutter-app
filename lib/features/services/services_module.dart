import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/services/services.dart';

class ServicesModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory<ServiceServices>(() {
      return ServiceServices(
        locator.get<HttpGet>(),
      );
    });
  }
}
