import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class ServiceModule {
  void register(ServiceLocator locator);
}

class ServiceLocator {
  final Map<Type, dynamic> _providerRegistry;
  final Map<Type, dynamic> _singletonRegistry;
  final Map<Type, dynamic> _factoryRegistry;
  final Map<Type, dynamic> _lazySingletonRegistry;

  ServiceLocator()
      : _singletonRegistry = Map<Type, dynamic>(),
        _providerRegistry = Map<Type, SingleChildWidget>(),
        _factoryRegistry = Map<Type, dynamic>(),
        _lazySingletonRegistry = Map<Type, dynamic>();

  List<SingleChildWidget> getProviders() => _providerRegistry.values.toList();

  T get<T>() {
    if (_singletonRegistry.containsKey(T)) {
      return _singletonRegistry[T];
    }
    if (_factoryRegistry.containsKey(T)) {
      return _factoryRegistry[T]();
    }
    if (_lazySingletonRegistry.containsKey(T)) {
      var instance = _lazySingletonRegistry[T]();
      _singletonRegistry[T] = instance;
      return instance;
    }

    throw ServiceNotFoundError(T);
  }

  void registerProvider<T>(T provider) {
    _providerRegistry[T] = Provider<T>(create: (_) => provider);
    registerSingleton<T>(provider);
  }

  void registerProviderFactory<T>(T Function() factory) {
    _providerRegistry[T] = Provider<T>(create: (_) => get<T>());
    registerLazySingleton(factory);
  }

  void registerSingleton<T>(T service) => _singletonRegistry[T] = service;

  void registerFactory<T>(T Function() factory) =>
      _factoryRegistry[T] = factory;

  void registerLazySingleton<T>(T Function() factory) =>
      _lazySingletonRegistry[T] = factory;

  void registerModule(ServiceModule module) => module.register(this);

  void override<T>(T service) => registerSingleton(service);
}

class ServiceNotFoundError extends Error {
  final Type type;

  ServiceNotFoundError(this.type);

  @override
  String toString() =>
      'The $type was not found. Make sure to register it under a module.';
}

typedef FactoryFunc<T> = T Function();

class ServiceLocatorProvider extends StatelessWidget {
  final Widget child;
  final ServiceLocator _serviceLocator;

  ServiceLocatorProvider({
    @required this.child,
    ServiceLocator serviceLocator,
  }) : _serviceLocator = serviceLocator;

  @override
  Widget build(BuildContext context) {
    var providers = _serviceLocator.getProviders();

    if (providers.isEmpty) {
      return makeServiceLocatorProvider();
    }

    return MultiProvider(
      providers: providers,
      child: makeServiceLocatorProvider(),
    );
  }

  Provider<ServiceLocator> makeServiceLocatorProvider() {
    return Provider<ServiceLocator>(
      create: (_) => _serviceLocator,
      child: child,
    );
  }
}
