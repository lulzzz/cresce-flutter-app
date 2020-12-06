import 'package:cresce_flutter_app/features/cresce_flutter_features.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:flutter/foundation.dart';
import 'package:mockito/mockito.dart';

void useFakeHttpLayer() {
  overrideDependency(makeHttpPost());
}

class HttpPostMock extends Mock implements HttpPost {}

HttpPost makeHttpPost() {
  var http = HttpPostMock();
  var formatter = JsonFormatter();

  when(http.post(
    'api/v1/authentication/',
    CredentialsDto(user: 'myUser', password: 'myPass'),
  )).thenAnswer(
    (_) {
      return SynchronousFuture(HttpResponse(
        formatter,
        statusCode: 200,
        content: LoginResultDto(
          organizationUrl: 'someOrganizationUrl',
          token: 'myAuthToken',
        ).serialize(formatter),
      ));
    },
  );

  when(http.post(
    'api/v1/authentication/',
    CredentialsDto(user: 'myUser1', password: 'myPass'),
  )).thenAnswer(
    (_) {
      return SynchronousFuture(HttpResponse(
        formatter,
        statusCode: 500,
      ));
    },
  );

  return http;
}