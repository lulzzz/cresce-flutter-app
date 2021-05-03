import 'package:cresce_flutter_app/core/core.dart';

extension ServiceLocatorExtensions on ServiceLocator {
  void registerDataLoader<T extends Deserialize>() {
    this.registerProviderFactory(
      () => DataLoaderCubit(this.get<EntityListGateway<T>>()),
    );
    this.registerLazySingleton<IBuildState<LoaderState<List<T>>>>(
      () => LoaderStateBuilder<T>(),
    );
  }
}
