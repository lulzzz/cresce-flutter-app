import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import 'http_client_fake.dart';
import 'test_model.dart';

main() {
  test('posting to url concatenates with authority', () async {
    var requestUrl;

    var httpPost = makeHttpPost(
      (request) {
        requestUrl = request.url.toString();
        return Future.value(Response("", 200));
      },
      authority: 'myAuthority',
    );

    await httpPost.post('test');

    expect(requestUrl, 'myAuthority/test');
  });

  test('posting sets content type to headers', () async {
    var contentType;
    var httpPost = makeHttpPost((request) {
      contentType = request.headers['content-type'];
      return Future.value(Response('', 200));
    });

    await httpPost.post('test');

    expect(contentType, 'application/json; charset=utf-8');
  });

  test('posting sends formatted body', () async {
    var body;
    var httpPost = makeHttpPost((request) {
      body = request.body;
      return Future.value(Response('', 200));
    });

    await httpPost.post('', TestModel());

    expect(body, '{"test":"data"}');
  });

  [200, 201].forEach((statusCode) {
    test('posting returns wasSuccess when status code is $statusCode',
        () async {
      var httpPost = makeHttpPost((request) {
        return Future.value(Response('', statusCode));
      });

      var result = await httpPost.post('test');

      expect(result.wasSuccess(), isTrue);
    });
  });

  test('posting returns result that can be deserialized', () async {
    var httpPost = makeHttpPost((request) {
      return Future.value(Response('{}', 200));
    });

    var result = await httpPost.post('test');

    expect(result.deserialize<TestModel>(TestModel()), isNotNull);
  });
}

HttpPost makeHttpPost(
  Future<Response> fn(dynamic request), {
  String authority = 'myAuthority',
}) {
  return HttpPost(
    HttpPipeline(authority, HttpClientMock(fn), JsonFormatter()),
  );
}
