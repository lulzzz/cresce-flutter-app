import 'package:cresce_flutter_app/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_http_layer.dart';

void main() {
  EquatableConfig.stringify = true;
  Token loginResult;
  bool failed = false;

  void onSuccess(Token result) {
    loginResult = result;
  }

  void onFailure() {
    failed = true;
  }

  test('on successful login calls given callback function', () async {
    final loginServices = makeService<LoginServices>();

    loginServices.login(
      Credentials(user: 'myUser', password: 'myPass'),
      successCallback: onSuccess,
    );

    expect(
      loginResult,
      Token(token: 'myAuthToken'),
    );
  });

  test('on failure login calls given callback function', () async {
    final loginServices = makeService<LoginServices>();

    loginServices.login(
      Credentials(user: 'myUser1', password: 'myPass'),
      failureCallback: onFailure,
    );

    expect(failed, isTrue);
  });
}
