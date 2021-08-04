import 'dart:io';

import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/appointments/services/appointment_services.dart';
import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/services/services.dart';
import 'package:cresce_flutter_app/service_configuration.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'monitor.dart';
import 'tester_extensions.dart';

main() {
  var shouldSkip = true;
  EquatableConfig.stringify = true;
  ServiceLocator locator;

  if (Platform.environment.containsKey('host')) {
    print('running on: ${Platform.environment['host']}');
    locator = makeServiceLocator(webApiUrl: Platform.environment['host']);
    shouldSkip = false;
  } else {
    locator = makeServiceLocator(
      webApiUrl: 'https://cresce-api.azurewebsites.net/',
    );
  }

  group('integration', () {
    test('health check returns ok', () async {
      var sut = locator.get<HttpGet>();

      var response = await sut.get('/');

      expect(response.statusCode, 200);
    });
    test('login in with valid credentials returns auth token', () async {
      var monitor = _makeMonitor();
      var sut = locator.get<LoginServices>();

      Token loginResult;
      sut.login(
        Credentials(user: 'myUser', password: 'myPass'),
        onSuccess: (result) {
          loginResult = result;
          monitor.signal();
        },
        onFailure: () => monitor.signal(),
      );
      await monitor.wait();

      expect(loginResult, isNotNull);
      expect(loginResult.token, isNotNull);
      expect(loginResult.token, isNotEmpty);
    });
    test('fetching employees for a given organization returns employees',
        () async {
      var sut = locator.get<EmployeeServices>();

      await login(locator);
      var employees = await sut.getList();

      expect(employees, [
        Employee(
          id: 1,
          name: 'Ricardo Nunes',
          title: 'Engineer',
        ),
      ]);
    });
    test('fetching customers returns customers', () async {
      var sut = locator.get<CustomerServices>();

      await loginEmployee(locator);
      var customers = await sut.getList();

      expect(customers, [
        Customer(
          id: 1,
          name: 'Diogo Quintas',
        ),
      ]);
    });
    test('fetching services returns services', () async {
      var sut = locator.get<ServiceServices>();

      await loginEmployee(locator);
      var services = await sut.getList();

      expect(services, [
        Service(
          id: 1,
          name: 'Development',
          value: 30.0,
        ),
      ]);
    });
    test('fetching appointments returns appointments', () async {
      var sut = locator.get<AppointmentServices>();

      await loginEmployee(locator);
      var appointments = await sut.getList();

      expect(appointments, [
        Appointment(
          id: 1,
          eventName: 'Diogo Quintas\nDevelopment',
          from: DateTime(2021, 3, 16, 9),
          to: DateTime(2021, 3, 16, 10),
          background: Colors.blue.shade500,
          isAllDay: false,
        ),
        Appointment(
          id: 2,
          eventName: 'Diogo Quintas\nDevelopment',
          from: DateTime(2021, 3, 16, 15),
          to: DateTime(2021, 3, 16, 16),
          background: Colors.blue.shade500,
          isAllDay: false,
          recurrence: WeeklyRecurrence(
            startDate: DateTime(2021, 3, 16),
            endDate: DateTime(2021, 4, 16),
            weekDays: [
              WeekDay.monday,
              WeekDay.tuesday,
            ],
          ),
        ),
      ]);
    });
    test('store appointment returns appointments', () async {
      var sut = locator.get<AppointmentServices>();

      await loginEmployee(locator);

      var appointments = await sut.getList();

      await sut.createAppointment(NewAppointment(
        service: Service(id: 1),
        customer: Customer(id: 1),
        date: DateTime(2021, 01, 01, 10, 15),
        duration: Duration(hours: 1),
      ));

      var appointmentsAfterCreate = await sut.getList();

      expect(appointmentsAfterCreate.length, isGreater(appointments.length));
    });
  }, skip: shouldSkip);
}

Future login(ServiceLocator locator) async {
  var monitor = _makeMonitor();
  var services = locator.get<LoginServices>();

  services.login(
    Credentials(user: 'myUser', password: 'myPass'),
    onSuccess: (_) => monitor.signal(),
    onFailure: () => monitor.signal(),
  );
  await monitor.wait();
}

Future loginEmployee(ServiceLocator locator) async {
  await login(locator);
  var monitor = _makeMonitor();
  var services = locator.get<EmployeeServices>();

  services.login(
    EmployeePin(employeeId: 1, pin: '1234'),
    onSuccess: (_) => monitor.signal(),
    onFailure: () => monitor.signal(),
  );
  await monitor.wait();
}

Monitor _makeMonitor() {
  return Monitor(
    waitTime: const Duration(milliseconds: 10),
    tries: 1000,
  );
}
