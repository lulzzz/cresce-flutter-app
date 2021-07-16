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
}

abstract class AppointmentStorage {
  void store();
}

class CreateAppointmentProvider extends Cubit<NewAppointment>
    implements
        CreateAppointmentPromptProvider,
        CreateAppointmentCleaner,
        AppointmentStorage {
  CreateAppointmentProvider() : super(NewAppointment());

  void setService(Service service) {
    emit(
      NewAppointment(
        service: service,
        customer: state.customer,
        duration: state.duration,
        weekDays: state.weekDays,
      ),
    );
  }

  void setCustomer(Customer customer) => emit(
        NewAppointment(
          service: state.service,
          customer: customer,
          duration: state.duration,
          weekDays: state.weekDays,
        ),
      );

  void setDuration(Duration duration) => emit(
        NewAppointment(
          service: state.service,
          customer: state.customer,
          duration: duration,
          weekDays: state.weekDays,
        ),
      );

  void setWeekdays(List<WeekDay> weekdays) => emit(
        NewAppointment(
          service: state.service,
          customer: state.customer,
          duration: state.duration,
          weekDays: weekdays,
        ),
      );

  @override
  void clearCustomer() => setCustomer(null);

  @override
  void clearDuration() => setDuration(null);

  @override
  void clearService() => setService(null);

  @override
  void clearWeekdays() => setWeekdays(null);

  void store() {}
}
