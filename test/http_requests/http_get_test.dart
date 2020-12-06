import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'http_client_fake.dart';
import 'test_model.dart';

main() {
  test('getting to url concatenates with authority', () async {
    var requestUrl;
    var httpGet = makeHttpGet(
      (request) {
        requestUrl = request.url.toString();
        return Future.value(Response("", 200));
      },
      authority: 'myAuthority/',
    );

    await httpGet.get('test');

    expect(requestUrl, 'myAuthority/test');
  });

  test('getting sets content type to headers', () async {
    var contentType;
    var httpGet = makeHttpGet((request) {
      contentType = request.headers['content-type'];
      return Future.value(Response('', 200));
    });

    await httpGet.get('test');

    expect(contentType, 'application/json; charset=utf-8');
  });

  [200, 201].forEach((statusCode) {
    test('getting returns wasSuccess when status code is $statusCode',
        () async {
      var httpGet = makeHttpGet((request) {
        return Future.value(Response('', statusCode));
      });

      var result = await httpGet.get('test');

      expect(result.wasSuccess(), isTrue);
    });
  });

  test('getting returns result that can be deserialized', () async {
    var httpGet = makeHttpGet((request) {
      return Future.value(Response('{}', 200));
    });

    var result = await httpGet.get('test');

    expect(result.deserialize<TestModel>(TestModel()), isNotNull);
  });
}

HttpGet makeHttpGet(
  Future<Response> fn(dynamic request), {
  String authority = 'myAuthority',
}) {
  return HttpGet(
    HttpPipeline(authority, HttpClientMock(fn), JsonFormatter()),
  );
}
