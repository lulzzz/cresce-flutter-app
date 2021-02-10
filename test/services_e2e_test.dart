import 'dart:io';

import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/organizations/organization.dart';
import 'package:cresce_flutter_app/service_configuration.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import 'monitor.dart';

main() {
  EquatableConfig.stringify = true;
  ServiceLocator locator;

  const localMode = String.fromEnvironment('local-mode');
  if (localMode == 'YES') {
    print('running in local mode');
    print('make sure to run web server:');
    print('docker run -d -p 5000:80 --name cresce.api alienengineer/cresce');
  } else {
    if (Platform.environment.containsKey('host')) {
      print('running on: ${Platform.environment['host']}');
      locator = makeServiceLocator(webApiUrl: Platform.environment['host']);
    } else {
      print('running on: http://localhost:5000/');
      locator = makeServiceLocator(webApiUrl: 'http://localhost:5000/');
    }
  }

  group('integration', () {
    test('health check returns ok', () async {
      var services = locator.get<HttpGet>();

      var response = await services.get('/');

      expect(response.statusCode, 200);
    });
    test('login in with valid credentials returns auth token', () async {
      var monitor = _makeMonitor();
      var services = locator.get<LoginServices>();

      Token loginResult;
      services.login(
        Credentials(user: 'myUser', password: 'myPass'),
        onSuccess: (result) {
          loginResult = result;
          monitor.signal();
        },
        onFailure: () => monitor.signal(),
      );
      await monitor.wait();

      expect(loginResult, isNotNull);
      expect(loginResult.token, isNotNull);
      expect(loginResult.token, isNotEmpty);
    });
    test('fetching employees for a given organization returns employees',
        () async {
      var services = locator.get<EmployeeServices>();

      await login(locator);
      var employees = await services.getEmployees(
        Organization(name: 'myOrganization'),
      );

      expect(employees, [
        Employee(
          id: 1,
          name: 'Ricardo Nunes',
          title: 'Engineer',
        ),
      ]);
    });
  });
}

Future login(ServiceLocator locator) async {
  var monitor = _makeMonitor();
  var services = locator.get<LoginServices>();

  services.login(
    Credentials(user: 'myUser', password: 'myPass'),
    onSuccess: (_) => monitor.signal(),
    onFailure: () => monitor.signal(),
  );
  await monitor.wait();
}

Monitor _makeMonitor() {
  return Monitor(
    waitTime: const Duration(milliseconds: 10),
    tries: 1000,
  );
}
