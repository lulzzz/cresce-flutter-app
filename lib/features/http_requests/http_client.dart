import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:http/http.dart' as http;

class HttpGet implements HttpMethod {
  HttpPipeline _pipeline;

  HttpGet(this._pipeline);

  Future<HttpResponse> get(String url) {
    return _pipeline.send(
      HttpRequest(
        method: HttpGetMethod(),
        uri: url,
      ),
    );
  }

  @override
  Future<http.Response> send(
    http.Client client,
    HttpRequest httpRequest,
    Encoder encoder,
  ) {
    return client.get(
      httpRequest.url,
      headers: httpRequest.headers,
    );
  }
}
