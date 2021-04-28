import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
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

class CreateAppointmentWidget extends StatefulWidget {
  final CreateAppointmentMessages messages;

  CreateAppointmentWidget({
    this.messages = const CreateAppointmentMessages(),
  });

  @override
  _CreateAppointmentWidgetState createState() =>
      _CreateAppointmentWidgetState();
}

class _CreateAppointmentWidgetState extends State<CreateAppointmentWidget> {
  final Field<Service> serviceField = Field.as<Service>();
  final Field<Customer> customerField = Field.as<Customer>();
  final Field<Duration> durationField = Field.as<Duration>();
  final Field<List<WeekDay>> recurrenceField = Field.as<List<WeekDay>>();
  final Field<FormStep> stepField =
      Field.as<FormStep>(initialValue: FormStep.service);

  final form = NewAppointmentForm();

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: displaySelectedInputs(context),
          ),
          stepField.buildWhenEquals(FormStep.service, (_) => FormDivider()),
          stepField.buildState(
            {
              FormStep.service: PromptCarousel<Service>(
                label: widget.messages.whichService,
                onSelect: (service) {
                  form.setService(service);
                  serviceField.setValue(service);
                  stepField.setValue(FormStep.customer);
                },
              ),
              FormStep.customer: PromptCarousel<Customer>(
                label: widget.messages.whoNeedsTheService,
                onSelect: (customer) {
                  form.setCustomer(customer);
                  customerField.setValue(customer);
                  stepField.setValue(FormStep.duration);
                },
              ),
              FormStep.duration: PromptDuration(
                messages: widget.messages,
                field: durationField,
                step: stepField,
                form: form,
              ),
              FormStep.recurrence: promptRecurrence(
                field: recurrenceField,
                step: stepField,
                form: form,
              ),
            },
          ),
        ],
      ),
    );
  }

  List<Widget> displaySelectedInputs(BuildContext context) {
    return [
      FieldThumbnail(
        entityField: serviceField,
        onTap: moveBackToPromptService,
      ),
      SizedBox(width: context.sizes.medium),
      FieldThumbnail(
        entityField: customerField,
        onTap: moveBackToPromptCustomer,
      ),
      SizedBox(width: context.sizes.medium),
      stepField.buildWhenEquals(
        FormStep.recurrence,
        (_) => InkWell(
          onTap: moveBackToPromptDuration,
          child: BitText(
            context.formatDuration(durationField.getValue()),
            style: BitTextStyles.h3,
          ),
        ),
      ),
    ];
  }

  void moveBackToPromptCustomer() {
    customerField.setValue(null);
    durationField.setValue(null);
    stepField.setValue(FormStep.customer);
  }

  void moveBackToPromptDuration() {
    durationField.setValue(null);
    stepField.setValue(FormStep.duration);
  }

  void moveBackToPromptService() {
    serviceField.setValue(null);
    customerField.setValue(null);
    stepField.setValue(FormStep.service);
  }

  Widget promptRecurrence({
    Field<List<WeekDay>> field,
    Field<FormStep> step,
    NewAppointmentForm form,
  }) {
    return PromptContainerWidget(
      child: WeekDaysWidget(field: recurrenceField),
      label: widget.messages.isRecurrence,
    );
  }
}

class PromptCustomer extends StatelessWidget {
  final CreateAppointmentMessages messages;

  const PromptCustomer({
    Key key,
    @required this.field,
    @required this.step,
    @required this.messages,
    this.form,
  }) : super(key: key);

  final CustomerForm form;
  final Field<Customer> field;
  final Field<FormStep> step;

  @override
  Widget build(BuildContext context) {
    return PromptContainerWidget(
      child: EntityCarouselWidget<Customer>(
        onSelect: (customer) {
          form.setCustomer(customer);
          field.setValue(customer);
          step.setValue(FormStep.duration);
        },
      ),
      label: messages.whoNeedsTheService,
    );
  }
}

class PromptService extends StatelessWidget {
  final void Function(Service service) onSelect;
  final String label;

  const PromptService({
    Key key,
    this.form,
    this.onSelect,
    this.label,
  }) : super(key: key);

  final ServiceForm form;

  @override
  Widget build(BuildContext context) {
    return PromptContainerWidget(
      child: EntityCarouselWidget<Service>(
        onSelect: onSelect,
      ),
      label: this.label,
    );
  }
}

class PromptDuration extends StatelessWidget {
  final CreateAppointmentMessages messages;

  const PromptDuration({
    Key key,
    @required this.field,
    @required this.step,
    @required this.messages,
    this.form,
  }) : super(key: key);

  final DurationForm form;
  final Field<Duration> field;
  final Field<FormStep> step;

  @override
  Widget build(BuildContext context) {
    return PromptContainerWidget(
      child: Column(
        children: [
          BitDurationPicker(
            min: const Duration(minutes: 30),
            max: const Duration(hours: 4),
            field: field,
            onChangeEnd: (duration) {
              form.setDuration(duration);
              step.setValue(FormStep.recurrence);
            },
          ),
          field.buildValue(
            (value) => BitText(
              DurationLocations().formatDuration(value),
              style: BitTextStyles.h3,
            ),
          ),
        ],
      ),
      label: messages.howLong,
    );
  }
}
