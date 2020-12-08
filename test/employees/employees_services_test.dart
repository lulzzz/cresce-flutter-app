import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:cresce_flutter_app/services_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_http_layer.dart';

main() {
  EquatableConfig.stringify = true;
  List<Employee> employees;
  bool failed = false;

  void onSuccess(List<Employee> result) {
    employees = result;
  }

  void onFailure() {
    failed = true;
  }

  group(EmployeeServices, () {
    test(
        'fetching employees for the given organization returns list of employees',
        () {
      var service = makeEmployeeServices();

      service.fetchEmployees(
        OrganizationDto(name: 'myOrganization'),
        onSuccess: onSuccess,
      );

      expect(employees, [Employee(name: 'test employee')]);
    });
  });
}

EmployeeServices makeEmployeeServices() {
  useFakeHttpLayer();
  return get<EmployeeServices>();
}
