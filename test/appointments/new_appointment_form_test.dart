import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(NewAppointmentForm, () {
    group('moving forward', () {
      test('new appointments prompts Service', () {
        var form = NewAppointmentForm();

        expect(form.getCurrentStep(), FormStep.service);
      });
      test('setting service moves to prompt Customer', () {
        var form = NewAppointmentForm();

        form.setService(Service(id: 1));

        expect(form.getCurrentStep(), FormStep.customer);
        expect(
          form.getNewAppointment(),
          NewAppointment(
            service: Service(id: 1),
          ),
        );
      });
      test('setting customer moves to prompt duration', () {
        var form = NewAppointmentForm();

        form.setCustomer(Customer(id: 2));

        expect(form.getCurrentStep(), FormStep.duration);
        expect(
          form.getNewAppointment(),
          NewAppointment(
            customer: Customer(id: 2),
          ),
        );
      });
      test('setting duration moves to prompt recurrence', () {
        var form = NewAppointmentForm();

        form.setDuration(Duration(hours: 3));

        expect(form.getCurrentStep(), FormStep.recurrence);
        expect(
          form.getNewAppointment(),
          NewAppointment(
            duration: Duration(hours: 3),
          ),
        );
      });
      test('setting recurrence keeps prompt recurrence', () {
        var form = NewAppointmentForm();

        form.setRecurrence(<WeekDay>[WeekDay.monday]);

        expect(form.getCurrentStep(), FormStep.recurrence);
        expect(
          form.getNewAppointment(),
          NewAppointment(
            weekDays: <WeekDay>[WeekDay.monday],
          ),
        );
      });
    });

    group('moving backward', () {
      NewAppointmentForm getFullyFilledForm() {
        var form = NewAppointmentForm();
        form.setService(Service(id: 1));
        form.setCustomer(Customer(id: 2));
        form.setDuration(Duration(hours: 3));
        form.setRecurrence(<WeekDay>[WeekDay.wednesday]);
        return form;
      }

      test('clean duration prompts duration', () {
        var form = getFullyFilledForm();

        form.clearDuration();

        expect(form.getCurrentStep(), FormStep.duration);
        expect(
          form.getNewAppointment(),
          NewAppointment(
            service: Service(id: 1),
            customer: Customer(id: 2),
          ),
        );
      });
      test('clean customer prompts customer', () {
        var form = getFullyFilledForm();

        form.clearCustomer();

        expect(form.getCurrentStep(), FormStep.customer);
        expect(
          form.getNewAppointment(),
          NewAppointment(
            service: Service(id: 1),
          ),
        );
      });
      test('clean service prompts service', () {
        var form = getFullyFilledForm();

        form.clearService();

        expect(form.getCurrentStep(), FormStep.service);
        expect(form.getNewAppointment(), NewAppointment());
      });
    });
  });
}
