import 'package:cresce_flutter_app/features/appointments/widgets/create_appointment_selected_inputs.dart';
import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter/widgets.dart';

import 'create_appointment_prompt.dart';

class CreateAppointmentWidget extends StatefulWidget {
  @override
  _CreateAppointmentWidgetState createState() =>
      _CreateAppointmentWidgetState();
}

class _CreateAppointmentWidgetState extends State<CreateAppointmentWidget> {
  final Field<FormStep> stepField =
      Field.as<FormStep>(initialValue: FormStep.service);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: stepField.buildWhenEquals(
        FormStep.recurrence,
        (value) => FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(FontAwesomeIcons.calendarPlus),
        ),
      ),
      body: Column(
        children: [
          CreateAppointmentSelectedInputs(),
          CreateAppointmentPrompt(),
        ],
      ),
    );
  }
}
