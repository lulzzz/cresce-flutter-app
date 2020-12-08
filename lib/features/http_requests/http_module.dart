import 'package:cresce_flutter_app/features/http_requests/formaters/decoders.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/services_locator.dart';

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
        responseFilters: [
          // PrintHttpResponseFilter(),
        ],
      ),
    );
    locator.registerFactory<HttpPost>(() {
      return HttpPost(locator.get<HttpPipeline>());
    });
    locator.registerFactory<HttpGet>(() {
      return HttpGet(locator.get<HttpPipeline>());
    });
  }
}

class PrintHttpResponseFilter implements HttpResponseFilter {
  @override
  HttpResponse apply(HttpResponse response) {
    print('StatusCode: ${response.statusCode}');
    print('Content: ${response.content}');
    return response;
  }
}
