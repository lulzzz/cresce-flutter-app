import 'package:cresce_flutter_app/features/appointments/widgets/create_appointment_selected_inputs.dart';
import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter/widgets.dart';

import 'create_appointment_prompt.dart';

class CreateAppointmentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: OnStateChange<NewAppointment>(
        AddAppointmentButtonWidgetFactory(),
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

class AddAppointmentButtonWidgetFactory
    implements WidgetFactory<NewAppointment> {
  @override
  Widget build(BuildContext context, NewAppointment state) {
    return FloatingActionButton(
      onPressed: () {
        context.get<AppointmentStorage>().store();
        Navigator.pop(context);
      },
      child: const Icon(FontAwesomeIcons.calendarPlus),
    );
  }

  @override
  bool canHandleState(NewAppointment state) => state.hasAllMandatoryFields();
}
