import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef Widget BuildCallback();

abstract class CreateAppointmentCleaner {
  void clearService();
  void clearCustomer();
  void clearDuration();
  void clearWeekdays();
}

abstract class CreateAppointmentPromptProvider {
  void setService(Service service);
  void setCustomer(Customer customer);
  void setDuration(Duration duration);
  void setWeekdays(List<WeekDay> weekdays);
  Widget buildPrompts({
    BuildCallback promptService,
    BuildCallback promptCustomer,
    BuildCallback promptDuration,
    BuildCallback promptWeekdays,
  });
}

class CreateAppointmentProvider extends Cubit<CreateAppointmentState>
    implements
        CreateAppointmentPromptProvider,
        CreateAppointmentCleaner,
        IBuildState<CreateAppointmentState> {
  CreateAppointmentProvider() : super(CreateAppointmentState());

  void setService(Service service) =>
      emit(state.copy(cleaner: this, service: service));

  void setCustomer(Customer customer) =>
      emit(state.copy(cleaner: this, customer: customer));

  void setDuration(Duration duration) =>
      emit(state.copy(cleaner: this, duration: duration));

  void setWeekdays(List<WeekDay> weekdays) =>
      emit(state.copy(cleaner: this, weekdays: weekdays));

  @override
  void clearCustomer() => setCustomer(null);

  @override
  void clearDuration() => setDuration(null);

  @override
  void clearService() => setService(null);

  @override
  void clearWeekdays() => setWeekdays(null);

  Widget buildPrompts({
    BuildCallback promptService,
    BuildCallback promptCustomer,
    BuildCallback promptDuration,
    BuildCallback promptWeekdays,
  }) {
    return build((_, state) {
      if (state.service == null) return promptService();
      if (state.customer == null) return promptCustomer();
      if (state.duration == null) return promptDuration();
      if (state.weekdays == null) return promptWeekdays();

      return Container();
    });
  }

  @override
  Widget build(builder) {
    return BlocBuilder<CreateAppointmentProvider, CreateAppointmentState>(
      builder: builder,
    );
  }
}

class CreateAppointmentState {
  final Service service;
  final Customer customer;
  final Duration duration;
  final List<WeekDay> weekdays;

  final CreateAppointmentCleaner _cleaner;

  CreateAppointmentState({
    CreateAppointmentCleaner cleaner,
    this.service,
    this.customer,
    this.duration,
    this.weekdays,
  }) : _cleaner = cleaner;

  CreateAppointmentState copy({
    CreateAppointmentCleaner cleaner,
    Service service,
    Customer customer,
    Duration duration,
    List<WeekDay> weekdays,
  }) {
    return CreateAppointmentState(
      cleaner: _cleaner,
      service: service ?? this.service,
      customer: customer ?? this.customer,
      duration: duration ?? this.duration,
      weekdays: weekdays ?? this.weekdays,
    );
  }

  Widget buildServiceWidget() {
    return safeBuild(service, (_) {
      return BitThumbnail(
        onTap: () => _cleaner.clearService(),
        width: 200,
        data: service.toThumbnailData(),
      );
    });
  }

  Widget buildCustomerWidget() {
    return safeBuild(customer, (_) {
      return BitThumbnail(
        onTap: () => _cleaner.clearCustomer(),
        width: 200,
        data: customer.toThumbnailData(),
      );
    });
  }

  Widget buildDurationWidget() {
    return safeBuild(duration, (context) {
      return InkWell(
        onTap: () => _cleaner.clearDuration(),
        child: BitText(
          context.formatDuration(duration),
          style: BitTextStyles.h3,
        ),
      );
    });
  }

  bool hasService() => service != null;
}
