import 'package:cresce_flutter_app/features/http_requests/formaters/decoders.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class HttpRequest {
  final String authority;
  final String uri;
  final Serializable body;
  final Map<String, String> headers;
  final HttpMethod method;

  HttpRequest({
    this.authority,
    this.method,
    this.uri,
    this.body,
    this.headers,
  });

  String get url => _makeUrl(uri);

  Future<http.Response> _send(http.Client client, Encoder encoder) {
    return method.send(
      client,
      this,
      encoder,
    );
  }

  HttpRequest copyWith({
    String authority,
    String uri,
    Serializable body,
    Map<String, String> headers,
    HttpMethod method,
  }) {
    return HttpRequest(
      authority: authority ?? this.authority,
      uri: uri ?? this.uri,
      body: body ?? this.body,
      method: method ?? this.method,
      headers: headers ?? this.headers,
    );
  }

  String _makeUrl(String uri) => _combine([authority, uri]);

  String _combine(List<String> list) {
    return list.map((part) {
      return part.endsWith('/') ? part.substring(0, part.length - 1) : part;
    }).join('/');
  }
}

abstract class HttpMethod {
  Future<http.Response> send(
    http.Client client,
    HttpRequest httpRequest,
    Encoder encoder,
  );
}

class HttpGetMethod implements HttpMethod {
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

class HttpResponse extends Equatable {
  final Decoder decoder;
  final HttpRequest request;
  final int statusCode;
  final String content;

  HttpResponse(
    this.decoder, {
    this.request,
    this.statusCode,
    this.content,
  });

  @override
  List<Object> get props => [statusCode, content];

  bool wasSuccess() => [200, 201].contains(statusCode);

  T deserialize<T>(Deserialize obj) => _cast<T>(
      shouldDeserialize() ? obj.deserialize(decoder.decode(content)) : obj);

  bool shouldDeserialize() => wasSuccess() && content != null;

  List<T> deserializeList<T>(Deserialize obj) {
    var mapped = decoder.decodeList(content);

    final casting = mapped.cast<Map<String, dynamic>>();

    return casting.map<T>((f) => obj.deserialize(f) as T).toList();
  }

  T _cast<T>(Object obj) => obj as T;
}

class HttpClientFactory {
  http.Client makeClient() => http.Client();
}

class HttpPipeline {
  final String authority;
  final HttpClientFactory factory;
  final Formatters formatters;

  HttpPipeline(
    this.authority,
    this.factory,
    this.formatters,
  );

  Future<HttpResponse> send(HttpRequest request) async {
    var client = factory.makeClient();
    try {
      var httpRequest = _setMissingFields(request);

      var response = await httpRequest._send(client, formatters.encoder);

      return _convertToHttpResponse(httpRequest, response);
    } finally {
      client.close();
    }
  }

  HttpRequest _setMissingFields(HttpRequest request) {
    return request.copyWith(
      authority: authority,
      headers: _makeHeaders(),
    );
  }

  HttpResponse _convertToHttpResponse(
    HttpRequest request,
    http.Response response,
  ) {
    return HttpResponse(
      formatters.decoder,
      request: request,
      statusCode: response.statusCode,
      content: response.body,
    );
  }

  Map<String, String> _makeHeaders() {
    return {
      'content-type': formatters.getContentType(),
    };
  }
}

abstract class Serializable {
  String serialize(Encoder encoder);
}

abstract class Deserialize {
  Object deserialize(Map<String, dynamic> data);
}

abstract class DeserializeList {
  List<Object> deserialize(List data);
}
