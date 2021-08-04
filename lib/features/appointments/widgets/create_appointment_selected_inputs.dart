import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateAppointmentSelectedInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _display(context).toList(),
    );
  }

  Iterable<Widget> _display(BuildContext context) sync* {
    final cleaner = context.get<CreateAppointmentCleaner>();

    yield OnStateChange<NewAppointment>(
      SelectedServiceWidgetFactory(cleaner),
    );
    yield OnStateChange<NewAppointment>(
      SelectedCustomerWidgetFactory(cleaner),
    );
    yield OnStateChange<NewAppointment>(
      SelectedDurationWidgetFactory(cleaner),
    );
  }
}

class SelectedDurationWidgetFactory implements WidgetFactory<NewAppointment> {
  final CreateAppointmentCleaner cleaner;

  SelectedDurationWidgetFactory(this.cleaner);

  @override
  Widget build(BuildContext context, NewAppointment state) {
    return InkWell(
      key: const Key('appointment_picked_duration'),
      onTap: () => cleaner.clearDuration(),
      child: BitText(
        context.formatDuration(state.duration),
        style: BitTextStyles.h3,
      ),
    );
  }

  @override
  bool canHandleState(NewAppointment state) => state.duration != null;
}

class SelectedCustomerWidgetFactory implements WidgetFactory<NewAppointment> {
  final CreateAppointmentCleaner cleaner;

  SelectedCustomerWidgetFactory(this.cleaner);

  @override
  Widget build(BuildContext context, NewAppointment state) {
    return BitMediumPadding(
      child: BitThumbnail(
        onTap: () => cleaner.clearCustomer(),
        width: 200,
        data: state.customer.toThumbnailData(),
      ),
    );
  }

  @override
  bool canHandleState(NewAppointment state) => state.customer != null;
}

class SelectedServiceWidgetFactory implements WidgetFactory<NewAppointment> {
  final CreateAppointmentCleaner cleaner;

  SelectedServiceWidgetFactory(this.cleaner);

  @override
  Widget build(BuildContext context, NewAppointment state) {
    return BitThumbnail(
      onTap: () => cleaner.clearService(),
      width: 200,
      data: state.service.toThumbnailData(),
    );
  }

  @override
  bool canHandleState(NewAppointment state) => state.service != null;
}
