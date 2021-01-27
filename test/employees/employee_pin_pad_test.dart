import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_bits/ui_bits.dart';

import '../tester_extensions.dart';

class EmployeePinPadWidget extends StatelessWidget {
  final Employee employee;
  final VoidCallback onSuccess;
  final Field<String> pinField = Field.asText();

  EmployeePinPadWidget({
    Key key,
    this.employee,
    this.onSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BitPinPad(
        onTap: (pin) {
          if (pinField.getValue() == "1234") {
            onSuccess();
          }
        },
        pinField: pinField,
      ),
    );
  }
}

main() {
  group(EmployeePinPadWidget, () {
    testWidgets('entering 4 digit pin logs in', (tester) async {
      var _wasLoggedIn = false;
      await tester.pumpWidgetInApp(
        EmployeePinPadWidget(
          employee: Employee(),
          onSuccess: () => _wasLoggedIn = true,
        ),
      );

      await tester.tap(find.text('1'));
      await tester.tap(find.text('2'));
      await tester.tap(find.text('3'));
      await tester.tap(find.text('4'));
      await tester.pumpAndSettle();

      expect(_wasLoggedIn, isTrue);
    });
  });
}
