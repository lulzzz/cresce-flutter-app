import 'package:cresce_flutter_app/features/cresce_flutter_features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../monitor.dart';

main() {
  EquatableConfig.stringify = true;
  Monitor monitor;
  LoginResultDto loginResult;

  setUp(() {
    monitor = Monitor(
      waitTime: const Duration(milliseconds: 10),
      tries: 10000,
    );
  });

  void onSuccess(LoginResultDto result) {
    loginResult = result;
    monitor.signal();
  }

  void onFailure() {
    monitor.signal();
  }

  test('login in with valid credentials returns auth token', () async {
    var services = get<LoginServices>();

    services.login(
      CredentialsDto(user: 'myUser', password: 'myPass'),
      successCallback: onSuccess,
      failureCallback: onFailure,
    );
    await monitor.wait();

    expect(loginResult, isNotNull);
    expect(loginResult.organizationUrl, 'api/v1/organizations/');
    expect(loginResult.token, isNotNull);
    expect(loginResult.token, isNotEmpty);
  });
}
