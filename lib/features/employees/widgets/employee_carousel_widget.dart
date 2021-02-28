import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

class EmployeeCarouselWidget extends StatelessWidget {
  final void Function(Employee employee) onSelect;

  EmployeeCarouselWidget({this.onSelect});

  @override
  Widget build(BuildContext context) {
    return BitFutureDataBuilder<List<Employee>>(
      future: getEmployees(context),
      onData: (data) => _makeCarousel(data),
    );
  }

  Widget _makeCarousel(List<Employee> employees) {
    return BitCarousel(
      children: employees.map((employee) {
        return BitThumbnail(
          onTap: () => onSelect?.call(employee),
          width: 200,
          data: employee.toThumbnailData(),
        );
      }).toList(),
    );
  }

  Future<List<Employee>> getEmployees(BuildContext context) {
    return context
        .get<EmployeeServices>()
        .getEmployees(Organization(name: 'myOrganization'));
  }
}
