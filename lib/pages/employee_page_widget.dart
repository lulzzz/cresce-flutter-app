import 'package:cresce_flutter_app/pages/pages.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

class EmployeePageWidget extends PageWidget {
  final Field<Employee> employeeField = Field.as<Employee>();

  @override
  Widget buildBody(BuildContext context) {
    return BitObservable<Employee>(
      field: employeeField,
      nullValue: () {
        return EntityCarouselWidget<Employee>(
          onSelect: (employee) => employeeField.setValue(employee),
        );
      },
      hasValue: (_) {
        return EmployeePinPadWidget(
          employee: employeeField,
          onSuccess: () => context.navigateTo<MainPageWidget>(),
        );
      },
    );
  }
}
