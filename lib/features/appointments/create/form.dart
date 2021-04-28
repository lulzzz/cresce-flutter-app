import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';

abstract class ServiceForm {
  void setService(Service service);
  void clearService();
}

abstract class CustomerForm {
  void setCustomer(Customer customer);
  void clearCustomer();
}

abstract class DurationForm {
  void setDuration(Duration duration);
  void clearDuration();
}

class NewAppointmentForm implements ServiceForm, CustomerForm, DurationForm {
  Service _service;
  Customer _customer;
  Duration _duration;
  List<WeekDay> _weekdays;

  final Field<FormStep> stepField =
      Field.as<FormStep>(initialValue: FormStep.service);

  FormStep getCurrentStep() => stepField.getValue();

  void setService(Service service) {
    stepField.setValue(FormStep.customer);
    _service = service;
  }

  void clearService() {
    _service = null;
    _customer = null;
    _duration = null;
    _weekdays = null;
    stepField.setValue(FormStep.service);
  }

  void setCustomer(Customer customer) {
    stepField.setValue(FormStep.duration);
    _customer = customer;
  }

  void clearCustomer() {
    _customer = null;
    _duration = null;
    _weekdays = null;
    stepField.setValue(FormStep.customer);
  }

  void setDuration(Duration duration) {
    stepField.setValue(FormStep.recurrence);
    _duration = duration;
  }

  void clearDuration() {
    _duration = null;
    _weekdays = null;
    stepField.setValue(FormStep.duration);
  }

  void setRecurrence(List<WeekDay> weekdays) {
    stepField.setValue(FormStep.recurrence);
    _weekdays = weekdays;
  }

  NewAppointment getNewAppointment() {
    return NewAppointment(
      service: _service,
      customer: _customer,
      duration: _duration,
      weekDays: _weekdays,
    );
  }
}

enum FormStep {
  service,
  customer,
  duration,
  recurrence,
}
