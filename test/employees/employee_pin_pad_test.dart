import 'package:cresce_flutter_app/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_bits/ui_bits.dart';

import '../tester_extensions.dart';

class EmployeePinPadMessages {
  final String wrongPinMessage;

  const EmployeePinPadMessages({
    this.wrongPinMessage = 'wrong pin, make sure this is your account.',
  });
}

class EmployeePinPadWidget extends StatelessWidget {
  final Employee employee;
  final VoidCallback onSuccess;
  final EmployeePinPadMessages messages;
  final Field<String> pinField = Field.asText();
  final Field<bool> wrongPassword = Field.asBool();

  EmployeePinPadWidget({
    Key key,
    this.employee,
    this.onSuccess,
    this.messages = const EmployeePinPadMessages(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BitObservable(
          field: wrongPassword,
          buildByState: {
            true: BitText(messages.wrongPinMessage),
            false: Container(),
          },
        ),
        BitPinPad(
          onTap: (pin) {
            if (pinField.getValue().length == 4) {
              context.get<EmployeeServices>().login(
                EmployeePin(
                  employeeId: employee.id,
                  pin: pinField.getValue(),
                ),
                onSuccess: (_) {
                  onSuccess();
                },
                onFailure: () {
                  wrongPassword.setValue(true);
                },
              );
            }
          },
          pinField: pinField,
        ),
      ],
    );
  }
}

main() {
  EquatableConfig.stringify = true;

  group(EmployeePinPadWidget, () {
    testWidgets('entering 4 digit pin logs in', (tester) async {
      var _wasLoggedIn = false;
      await tester.pumpWidgetInApp(
        EmployeePinPadWidget(
          employee: Employee(id: 1),
          onSuccess: () => _wasLoggedIn = true,
        ),
      );

      await tester.tap(find.text('1'));
      await tester.tap(find.text('2'));
      await tester.tap(find.text('3'));
      await tester.tap(find.text('4'));
      await tester.pumpAndSettle();

      expect(_wasLoggedIn, isTrue);
      expect(find.text('wrong pin, make sure this is your account.'),
          findsNothing);
    });
    testWidgets('wrong pin prompts a new pin', (tester) async {
      var _wasLoggedIn = false;
      await tester.pumpWidgetInApp(
        EmployeePinPadWidget(
          employee: Employee(id: 1),
          onSuccess: () => _wasLoggedIn = true,
        ),
      );

      await tester.tap(find.text('1'));
      await tester.tap(find.text('2'));
      await tester.tap(find.text('3'));
      await tester.tap(find.text('5'));
      await tester.pumpAndSettle();

      expect(_wasLoggedIn, isFalse);
      expect(find.text('wrong pin, make sure this is your account.'),
          findsOneWidget);
    });
  });
}
