import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/widgets.dart';

class EmployeeCarouselWidget extends EntityCarouselWidget<Employee> {
  EmployeeCarouselWidget({void Function(Employee employee) onSelect})
      : super(
          onSelect: onSelect,
          entitiesFuture: getEmployees,
        );

  static Future<List<Employee>> getEmployees(BuildContext context) {
    return context
        .get<EmployeeServices>()
        .getEmployees(Organization(name: 'myOrganization'));
  }
}
