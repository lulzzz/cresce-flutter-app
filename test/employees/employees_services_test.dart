import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_http_layer.dart';

main() {
  EquatableConfig.stringify = true;

  group(EmployeeServices, () {
    test(
        'fetching employees for the given organization returns list of employees',
        () async {
      var service = makeService<EmployeeServices>();

      var employees = await service.getEmployees(
        Organization(name: 'myOrganization'),
      );

      expect(employees, [
        Employee(
          name: 'test employee',
          title: 'test title',
        )
      ]);
    });
    test('fetching employees for unknown organization calls failure callback',
        () async {
      var service = makeService<EmployeeServices>();

      var employees = await service.getEmployees(
        Organization(name: 'unknown'),
      );

      expect(employees, []);
    });
    test('validating pin return employee authorization', () async {
      var service = makeService<EmployeeServices>();
      Token token;

      service.login(
        EmployeePin(employeeId: '1', pin: '1234'),
        onSuccess: (result) => token = result,
      );

      expect(token, isNotNull);
    });
    test('validating pin registers token', () async {
      var tokenRepository = TokenRepository();
      var service = makeService<EmployeeServices>(
        overrideDependency: (locator) {
          locator.overrideDependency(tokenRepository);
        },
      );
      Token token;

      service.login(
        EmployeePin(employeeId: '1', pin: '1234'),
        onSuccess: (result) => token = result,
      );

      expect(tokenRepository.getToken(), token);
    });
    test('logout employee reverts employee token to user token', () async {
      var tokenRepository = TokenRepository();
      tokenRepository.store(Token(token: 'USER TOKEN'));

      var service = makeService<EmployeeServices>(
        overrideDependency: (locator) {
          locator.overrideDependency(tokenRepository);
        },
      );
      service.login(EmployeePin(employeeId: '1', pin: '1234'));

      service.logout();

      expect(tokenRepository.getToken(), Token(token: 'USER TOKEN'));
    });
    test('validating pin return calls failure when login is invalid', () async {
      var service = makeService<EmployeeServices>();
      var failed = false;

      service.login(
        EmployeePin(employeeId: '1', pin: '12345'),
        onFailure: () => failed = true,
      );

      expect(failed, isTrue);
    });
  });
}
