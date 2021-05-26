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
    var provider = context.get<CreateAppointmentPromptProvider>();
    var messages = context.getLocalization<CreateAppointmentMessages>();

    return provider.buildPrompts(
      promptService: () => PromptCarousel<Service>(
        label: messages.whichService,
        onSelect: (service) => provider.setService(service),
      ),
      promptCustomer: () => PromptCarousel<Customer>(
        label: messages.whoNeedsTheService,
        onSelect: (customer) => provider.setCustomer(customer),
      ),
      promptDuration: () => DurationPrompt(
        label: messages.howLong,
        onSelect: (duration) => provider.setDuration(duration),
      ),
      promptWeekdays: () => WeekDaysPrompt(
        label: messages.isRecurrence,
        onChange: (weekdays) => provider.setWeekdays(weekdays),
      ),
    );
  }
}
