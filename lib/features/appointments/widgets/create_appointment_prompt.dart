import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/widgets.dart';

class CreateAppointmentMessages {
  final String isRecurrence;
  final String whoNeedsTheService;
  final String whichService;
  final String howLong;

  const CreateAppointmentMessages({
    this.isRecurrence = 'Has recurrence?',
    this.whoNeedsTheService = 'Who needs the service?',
    this.whichService = 'Which service?',
    this.howLong = 'How long is the session?',
  });
}

class CreateAppointmentPrompt extends StatelessWidget {
  const CreateAppointmentPrompt({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [OnStateChange<NewAppointment>(_PromptWidgetFactory())],
    );
  }
}

class _PromptWidgetFactory implements WidgetFactory<NewAppointment> {
  @override
  Widget build(BuildContext context, NewAppointment state) {
    var provider = context.get<CreateAppointmentPromptProvider>();
    var messages = context.getLocalization<CreateAppointmentMessages>();

    if (state.service == null) {
      return PromptCarousel<Service>(
        label: messages.whichService,
        onSelect: (service) => provider.setService(service),
      );
    }

    if (state.customer == null) {
      return PromptCarousel<Customer>(
        label: messages.whoNeedsTheService,
        onSelect: (customer) => provider.setCustomer(customer),
      );
    }

    if (state.duration == null) {
      return DurationPrompt(
        label: messages.howLong,
        onSelect: (duration) => provider.setDuration(duration),
      );
    }

    return WeekDaysPrompt(
      label: messages.isRecurrence,
      onChange: (weekdays) => provider.setWeekdays(weekdays),
    );
  }

  @override
  bool canHandleState(NewAppointment state) => true;
}
