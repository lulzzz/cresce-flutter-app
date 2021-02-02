import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

class EmployeePageWidget extends StatelessWidget {
  final String title;
  final Field<Employee> employeeId = Field.as<Employee>();

  EmployeePageWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25.0),
              child: BitObservable<Employee>(
                field: employeeId,
                builder: (value) {
                  if (value != null) {
                    return EmployeePinPadWidget(
                      employee: value,
                    );
                  }

                  return EmployeeCarouselWidget(
                    onSelect: (employee) {
                      employeeId.setValue(employee);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
