import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAppointmentStorage implements CreateAppointmentGateway {
  List<NewAppointment> _appointments = [];

  List<NewAppointment> getList() => _appointments;

  @override
  Future<void> createAppointment(NewAppointment newAppointment) async {
    _appointments.add(newAppointment);
  }
}

void main() {
  group(CreateAppointmentProvider, () {
    test('storing an appointment creates a new Appointment', () {
      var storage = FakeAppointmentStorage();

      var provider = CreateAppointmentProvider(
        storage,
        initialState: NewAppointment(
          service: Service(id: 1),
          customer: Customer(id: 1),
          duration: Duration(hours: 1),
          weekDays: [WeekDay.monday],
        ),
      );

      provider.store();

      expect(storage.getList(), [
        NewAppointment(
          service: Service(id: 1),
          customer: Customer(id: 1),
          duration: Duration(hours: 1),
          weekDays: [WeekDay.monday],
        ),
      ]);
    });

    test('storing an appointment clears provider state', () {
      var storage = FakeAppointmentStorage();

      var provider = CreateAppointmentProvider(
        storage,
        initialState: NewAppointment(
          service: Service(id: 1),
          customer: Customer(id: 1),
          duration: Duration(hours: 1),
          weekDays: [WeekDay.monday],
        ),
      );

      provider.store();

      expect(provider.state, NewAppointment());
    });
  });
}
