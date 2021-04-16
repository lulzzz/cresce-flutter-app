import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

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
  final Field<Step> stepField = Field.as<Step>();

  @override
  void initState() {
    super.initState();
    stepField.setValue(Step.service);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BitObservable(
        field: stepField,
        buildByState: {
          Step.recurrence: BitAnimations.scale().wrapWidget(
            child: FloatingActionButton(
              onPressed: () {
                recurrenceField.getValue().forEach((element) {
                  print(element.getWeekDay());
                });
                Navigator.pop(context);
              },
              child: const Icon(FontAwesomeIcons.calendarPlus),
            ),
          ),
        },
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: displaySelectedInputs(context),
          ),
          BitObservable(
            field: stepField,
            hasValue: (value) {
              if (value == Step.service) return Container();

              return FormDivider();
            },
          ),
          BitObservable(
            field: stepField,
            buildByState: {
              Step.service: PromptService(
                messages: widget.messages,
                field: serviceField,
                step: stepField,
              ),
              Step.customer: PromptCustomer(
                messages: widget.messages,
                field: customerField,
                step: stepField,
              ),
              Step.duration: PromptDuration(
                messages: widget.messages,
                field: durationField,
                step: stepField,
              ),
              Step.recurrence:
                  promptRecurrence(field: recurrenceField, step: stepField),
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
      BitObservable<Step>(
        field: stepField,
        buildByState: {
          Step.recurrence: InkWell(
            onTap: moveBackToPromptDuration,
            child: BitText(
              context.formatDuration(durationField.getValue()),
              style: BitTextStyles.h3,
            ),
          )
        },
      ),
    ];
  }

  void moveBackToPromptCustomer() {
    customerField.setValue(null);
    durationField.setValue(null);
    stepField.setValue(Step.customer);
  }

  void moveBackToPromptDuration() {
    durationField.setValue(null);
    stepField.setValue(Step.duration);
  }

  void moveBackToPromptService() {
    serviceField.setValue(null);
    customerField.setValue(null);
    stepField.setValue(Step.service);
  }

  Widget promptRecurrence({Field<List<WeekDay>> field, Field<Step> step}) {
    return PromptContainerWidget(
      child: WeekDaysWidget(
        field: recurrenceField,
      ),
      label: widget.messages.isRecurrence,
    );
  }
}

class PromptCarousel<TEntity extends ThumbnailDataFactory>
    extends StatelessWidget {
  final CreateAppointmentMessages messages;
  final Field<TEntity> field;
  final void Function(TEntity employee) onSelect;

  const PromptCarousel({
    Key key,
    @required this.field,
    @required this.messages,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PromptContainerWidget(
      child: EntityCarouselWidget<TEntity>(onSelect: onSelect),
      label: messages.whichService,
    );
  }
}

class FormDivider extends StatelessWidget {
  const FormDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BitMediumPadding(
      options: BitEdgeInsetsOptions.combine([
        BitEdgeInsetsOptions.bottom,
        BitEdgeInsetsOptions.top,
      ]),
      child: Divider(
        color: context.theme.primaryColor,
      ),
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
  }) : super(key: key);

  final Field<Customer> field;
  final Field<Step> step;

  @override
  Widget build(BuildContext context) {
    return PromptContainerWidget(
      child: EntityCarouselWidget<Customer>(
        onSelect: (customer) {
          field.setValue(customer);
          step.setValue(Step.duration);
        },
      ),
      label: messages.whoNeedsTheService,
    );
  }
}

class PromptService extends StatelessWidget {
  final CreateAppointmentMessages messages;

  const PromptService({
    Key key,
    @required this.field,
    @required this.step,
    @required this.messages,
  }) : super(key: key);

  final Field<Service> field;
  final Field<Step> step;

  @override
  Widget build(BuildContext context) {
    return PromptContainerWidget(
      child: EntityCarouselWidget<Service>(
        onSelect: (service) {
          field.setValue(service);
          step.setValue(Step.customer);
        },
      ),
      label: messages.whichService,
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
  }) : super(key: key);

  final Field<Duration> field;
  final Field<Step> step;

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
              step.setValue(Step.recurrence);
            },
          ),
          BitObservable(
            field: field,
            hasValue: (value) {
              return BitText(
                DurationLocations().formatDuration(value),
                style: BitTextStyles.h3,
              );
            },
          ),
        ],
      ),
      label: messages.howLong,
    );
  }
}

enum Step {
  service,
  customer,
  duration,
  recurrence,
}
