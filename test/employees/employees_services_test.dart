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
        () {
      var service = makeService<EmployeeServices>();
      List<Employee> employees;

      service.fetchEmployees(
        Organization(name: 'myOrganization'),
        onSuccess: (result) => employees = result,
      );

      expect(employees, [
        Employee(
          name: 'test employee',
          title: 'test title',
        )
      ]);
    });
    test('fetching employees for unknown organization calls failure callback',
        () {
      var service = makeService<EmployeeServices>();
      bool failed = false;

      service.fetchEmployees(
        Organization(name: 'unknownOrg'),
        onFailure: () => failed = true,
      );

      expect(failed, isTrue);
    });
  });
}
