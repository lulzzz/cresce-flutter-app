import 'package:cresce_flutter_app/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_http_layer.dart';

void main() {
  EquatableConfig.stringify = true;
  LoginResultDto loginResult;
  bool failed = false;

  void onSuccess(LoginResultDto result) {
    loginResult = result;
  }

  void onFailure() {
    failed = true;
  }

  test('on successful login calls given callback function', () async {
    final loginServices = makeLoginServices();

    loginServices.login(
      CredentialsDto(user: 'myUser', password: 'myPass'),
      successCallback: onSuccess,
    );

    expect(
      loginResult,
      LoginResultDto(
        organizationUrl: 'someOrganizationUrl',
        token: 'myAuthToken',
      ),
    );
  });

  test('on successful login without callback doesnt fail', () async {
    final loginServices = makeLoginServices();

    loginServices.login(CredentialsDto(user: 'myUser', password: 'myPass'));
  });

  test('on failure login calls given callback function', () async {
    final loginServices = makeLoginServices();

    loginServices.login(
      CredentialsDto(user: 'myUser1', password: 'myPass'),
      failureCallback: onFailure,
    );

    expect(failed, isTrue);
  });

  test('on failure login without callback doesnt fail', () async {
    final loginServices = makeLoginServices();

    loginServices.login(
      CredentialsDto(user: 'myUser1', password: 'myPass'),
    );
  });
}

LoginServices makeLoginServices() {
  useFakeHttpLayer();
  return get<LoginServices>();
}
