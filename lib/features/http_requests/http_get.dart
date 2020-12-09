import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:http/http.dart' as http;

class HttpGet implements HttpMethod {
  HttpPipeline _pipeline;

  HttpGet(this._pipeline);

  Future<HttpResponse> get(String url) {
    return _pipeline.send(
      HttpRequest(
        method: this,
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

extension HttpGetExtensions on HttpGet {
  void fetchList<T extends Deserialize>({
    String url,
    void Function(List<T> data) onSuccess,
    void Function() onFailure,
    Deserialize deserialize,
  }) {
    this.get(url).then((value) {
      if (value.wasSuccess()) {
        onSuccess(value.deserializeList(deserialize));
      } else {
        onFailure();
      }
    });
  }
}
