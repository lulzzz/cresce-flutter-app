import 'package:cresce_flutter_app/features/authentication/authentication.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:get_it/get_it.dart';

var _serviceLocator = ServiceLocator._internal(
  'http://localhost:5000/',
);

ServiceLocator get = _serviceLocator;

void overrideDependency<T>(T service) {
  _serviceLocator._getIt.allowReassignment = true;
  _serviceLocator._getIt.registerSingleton(service);
}

abstract class ServiceModule {
  void register(ServiceLocator locator);
}

class ServiceLocator {
  GetIt _getIt = GetIt.instance;

  ServiceLocator._internal(String authority) {
    _init(authority);
  }

  void _init(String authority) {
    registerModule(HttpModule(authority));
    registerModule(AuthenticationModule());
  }

  void registerModule(ServiceModule module) => module.register(this);

  void registerSingleton<T>(T service) => _getIt.registerSingleton<T>(service);

  void registerFactory<T>(T Function() factory) =>
      _getIt.registerFactory<T>(() => factory());

  T get<T>() => _getIt<T>();

  T call<T>() => get<T>();
}
