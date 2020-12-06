import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';

class AuthenticationModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory<LoginServices>(() {
      return LoginServices(get<HttpPost>());
    });
  }
}
