import 'dart:io';

import 'package:cresce_flutter_app/core/core.dart';

class HttpModule implements ServiceModule {
  String _authority;

  HttpModule(this._authority);

  @override
  void register(ServiceLocator locator) {
    locator.registerSingleton<Formatters>(JsonFormatter());
    locator.registerSingleton<HttpClientFactory>(HttpClientFactory());
    locator.registerFactory(
      () => HttpPipeline(
        locator.get<HttpClientFactory>(),
        locator.get<Formatters>(),
        responseFilters: [
          PrintHttpFilter(locator.get<Formatters>()),
        ],
        requestFilters: [
          SetAuthorityRequestFilter(_authority),
          SetContentTypeRequestFilter(locator.get<Formatters>()),
          SetAuthorizationHeader(locator.get<TokenRepository>()),
          PrintHttpFilter(locator.get<Formatters>()),
        ],
        exceptionFilters: [
          PrintHttpFilter(locator.get<Formatters>()),
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

class SetAuthorizationHeader implements HttpRequestFilter {
  final TokenRepository _tokenRepository;

  SetAuthorizationHeader(this._tokenRepository);

  @override
  HttpRequest filterRequest(HttpRequest request) {
    var token = _tokenRepository.getToken();

    if (token != null) {
      request.headers[HttpHeaders.authorizationHeader] = token.toBearer();
    }

    return request;
  }
}

class PrintHttpFilter
    implements HttpResponseFilter, HttpRequestFilter, ExceptionFilter {
  final Formatters _formatters;
  PrintHttpFilter(this._formatters);

  @override
  HttpResponse filterResponse(HttpResponse response) {
    print('StatusCode: ${response.statusCode}');
    print('Content: ${response.content}');
    if (!response.wasSuccess() && response.originalResponse != null) {
      print('reason ${response.originalResponse.reasonPhrase}');
      print('headers ${response.originalResponse.headers}');
    }
    return response;
  }

  @override
  HttpRequest filterRequest(HttpRequest request) {
    print('Url: ${request.url}');
    print('Headers: ${request.headers}');
    print('Body: ${request.body?.serialize(_formatters)}');
    return request;
  }

  @override
  bool filterException(dynamic e) {
    print('exception filter');
    print(e);
    return true;
  }
}
