import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/widgets.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:cresce_flutter_app/core/core.dart';

class EmployeePinPadMessages {
  final String wrongPinMessage;
  final String pinInput;

  const EmployeePinPadMessages({
    this.wrongPinMessage = 'wrong pin, make sure this is your account.',
    this.pinInput = 'Pin',
  });
}

class EmployeePinPadWidget extends StatelessWidget {
  final Field<Employee> employee;
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
        Container(
          width: 300,
          child: BitInputPasswordField(
            FieldLabels(
              label: messages.pinInput,
              icon: FontAwesomeIcons.userLock,
            ),
            field: pinField,
          ),
        ),
        BitObservable(
          field: wrongPassword,
          buildByState: {
            true: BitText(messages.wrongPinMessage),
            false: Container(),
          },
        ),
        SizedBox(height: context.sizes.medium),
        BitPinPad(
          onTapBack: () => employee.setValue(null),
          onTap: (pin) {
            if (pinField.getValue().length == 4) {
              loginEmployee(context);
            }
          },
          pinField: pinField,
        ),
      ],
    );
  }

  void loginEmployee(BuildContext context) {
    var services = context.get<EmployeeServices>();
    services.login(
      EmployeePin(
        employeeId: employee.getValue().id,
        pin: pinField.getValue(),
      ),
      onSuccess: (_) => onSuccess?.call(),
      onFailure: () => wrongPassword.setValue(true),
    );
  }
}
