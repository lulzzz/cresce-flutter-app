import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/services_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../monitor.dart';

main() {
  EquatableConfig.stringify = true;
  Monitor monitor;
  Token loginResult;

  setUp(() {
    monitor = Monitor(
      waitTime: const Duration(milliseconds: 10),
      tries: 10000,
    );
  });

  void onSuccess(Token result) {
    loginResult = result;
    monitor.signal();
  }

  void onFailure() {
    monitor.signal();
  }

  test('login in with valid credentials returns auth token', () async {
    var services = get<LoginServices>();

    services.login(
      Credentials(user: 'myUser', password: 'myPass'),
      onSuccess: onSuccess,
      onFailure: onFailure,
    );
    await monitor.wait();

    expect(loginResult, isNotNull);
    expect(loginResult.token, isNotNull);
    expect(loginResult.token, isNotEmpty);
  });
}
