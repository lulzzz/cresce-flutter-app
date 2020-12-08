import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:http/http.dart' as http;

class HttpGet implements HttpMethod {
  HttpPipeline _pipeline;

  HttpGet(this._pipeline);

  Future<HttpResponse> get(String url, [Token token]) {
    return _pipeline.send(
      HttpRequest(
        method: this,
        uri: url,
        token: token,
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
