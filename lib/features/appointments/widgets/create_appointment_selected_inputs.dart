import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateAppointmentSelectedInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateBuilder<CreateAppointmentState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _displaySelectedInputs(context, state).toList(),
        );
      },
    );
  }

  Iterable<Widget> _displaySelectedInputs(
    BuildContext context,
    CreateAppointmentState state,
  ) sync* {
    yield state.buildServiceWidget();
    yield state.buildCustomerWidget();
    yield state.buildDurationWidget();

    if (state.hasService()) {
      yield FormDivider();
    }
  }
}
