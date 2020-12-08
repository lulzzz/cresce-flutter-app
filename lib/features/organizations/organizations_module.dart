import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:cresce_flutter_app/services_locator.dart';

class OrganizationsModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory(
      () => OrganizationServices(
        locator.get<HttpGet>(),
      ),
    );
  }
}
