import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:cresce_flutter_app/services_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:mockito/mockito.dart';

void useFakeHttpLayer() {
  overrideDependency(makeHttpPost());
  overrideDependency(makeHttpGet());
}

class HttpPostMock extends Mock implements HttpPost {}

class HttpGetMock extends Mock implements HttpGet {}

HttpGet makeHttpGet() {
  var httpGet = HttpGetMock();
  var formatter = JsonFormatter();

  when(httpGet.get('api/v1/unknown_user/organization')).thenAnswer((_) {
    return SynchronousFuture(HttpResponse(
      formatter,
      statusCode: 400,
    ));
  });

  when(httpGet.get('api/v1/myUser/organization')).thenAnswer((_) {
    return SynchronousFuture(HttpResponse(
      formatter,
      statusCode: 200,
      content: OrganizationListDto([
        OrganizationDto(name: 'myOrg'),
      ]).serialize(formatter),
    ));
  });

  setupEmployeesHttpGet(httpGet, formatter);

  return httpGet;
}

void setupEmployeesHttpGet(HttpGetMock httpGet, JsonFormatter formatter) {
  when(httpGet.get('api/v1/organization/myOrganization/employees'))
      .thenAnswer((_) {
    return SynchronousFuture(HttpResponse(
      formatter,
      statusCode: 200,
      content: EmployeeList([
        Employee(name: 'test employee'),
      ]).serialize(formatter),
    ));
  });
}

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
