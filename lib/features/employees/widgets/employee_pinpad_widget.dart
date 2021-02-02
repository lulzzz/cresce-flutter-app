import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

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
