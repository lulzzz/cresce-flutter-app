import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:http/http.dart' as http;

class HttpPost implements HttpMethod {
  HttpPipeline _pipeline;

  HttpPost(this._pipeline);

  Future<HttpResponse> post(String url, [Serializable body]) {
    return _pipeline.send(
      HttpRequest(
        method: this,
        body: body,
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
    return client.post(
      httpRequest.url,
      headers: httpRequest.headers,
      body: httpRequest.body?.serialize(encoder),
    );
  }
}
