import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/http_requests/formaters/decoders.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';

class HttpModule implements ServiceModule {
  String _authority;

  HttpModule(this._authority);

  @override
  void register(ServiceLocator locator) {
    locator.registerSingleton<Formatters>(JsonFormatter());
    locator.registerSingleton<HttpClientFactory>(HttpClientFactory());
    locator.registerFactory(
      () => HttpPipeline(
        _authority,
        locator.get<HttpClientFactory>(),
        locator.get<Formatters>(),
      ),
    );
    locator.registerFactory<HttpPost>(() {
      return HttpPost(locator.get<HttpPipeline>());
    });
  }
}
