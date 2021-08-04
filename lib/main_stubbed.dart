import 'package:cresce_flutter_app/app.dart';
import 'package:cresce_flutter_app/features/appointments/services/appointment_services.dart';
import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/images/customer_images.dart';
import 'package:cresce_flutter_app/images/employee_images.dart';
import 'package:cresce_flutter_app/images/service_images.dart';
import 'package:flutter/material.dart';

void main() {
  print('running in stubbed mode');

  runApp(makeApp(
    home: CreateAppointmentWidget(),
    webApiUrl: 'http://10.0.2.2:5000',
    overrideDependencies: (locator) {
      locator.registerSingleton<LoginServices>(StubbedLoginServices());
      locator
          .registerSingleton<AppointmentServices>(StubbedAppointmentServices());
      locator.registerSingleton<EmployeeServices>(StubbedEmployeeServices());
      locator.registerSingleton<EntityListGateway<Service>>(
          StubbedServiceServices());
      locator.registerSingleton<EntityListGateway<Customer>>(
          StubbedCustomerServices());
      locator.registerSingleton<EntityListGateway<Employee>>(
          StubbedEmployeeServices());
      locator.registerSingleton<OrganizationServices>(
          StubbedOrganizationServices());
    },
  ));
}

class StubbedCustomerServices implements EntityListGateway<Customer> {
  @override
  Future<List<Customer>> getList() {
    return Future.value([
      Customer(
        id: 1,
        name: 'Tainá Elisa',
        image: customerImage,
      ),
      Customer(
        id: 1,
        name: 'Tainá Elisa',
        image: customerImage,
      ),
      Customer(
        id: 1,
        name: 'Tainá Elisa',
        image: customerImage,
      ),
      Customer(
        id: 1,
        name: 'Tainá Elisa',
        image: customerImage,
      ),
      Customer(
        id: 1,
        name: 'Tainá Elisa',
        image: customerImage,
      ),
      Customer(
        id: 1,
        name: 'Tainá Elisa',
        image: customerImage,
      ),
    ]);
  }
}

class StubbedAppointmentServices extends AppointmentServices {
  StubbedAppointmentServices() : super(null, null);

  @override
  Future<List<Appointment>> getList() {
    return Future.value([
      Appointment(
        eventName: 'Tiago Silva\nFisioterapia',
        from: DateTime(2021, 3, 16, 8),
        to: DateTime(2021, 3, 16, 12),
        background: Colors.blue,
        isAllDay: false,
      ),
      Appointment(
        eventName: 'Diogo Esteves\nTerapia da Fala',
        from: DateTime(2021, 3, 16, 10),
        to: DateTime(2021, 3, 16, 11),
        background: Colors.red,
        isAllDay: false,
      ),
      Appointment(
        eventName: 'Diogo Esteves\nTerapia da Fala',
        from: DateTime(2021, 3, 16, 10),
        to: DateTime(2021, 3, 16, 11),
        background: Colors.green,
        isAllDay: false,
      ),
      Appointment(
        eventName: 'Diogo Esteves\nTerapia da Fala',
        from: DateTime(2021, 3, 16, 10),
        to: DateTime(2021, 3, 16, 11),
        background: Colors.orange,
        isAllDay: false,
      ),
      Appointment(
        eventName: 'Diogo Esteves\nTerapia da Fala',
        from: DateTime(2021, 3, 16, 10),
        to: DateTime(2021, 3, 16, 11),
        background: Colors.brown,
        isAllDay: false,
      ),
    ]);
  }
}

class StubbedServiceServices implements ServiceServices {
  @override
  Future<List<Service>> getList() {
    return Future.value([
      Service(
        id: 1,
        name: 'Fisioterapia',
        image: serviceImage1,
      ),
      Service(
        id: 2,
        name: 'Terapia da Fala',
        image: serviceImage2,
      ),
    ]);
  }
}

class StubbedOrganizationServices implements OrganizationServices {
  @override
  Future<List<Organization>> getOrganizations(String userId) {
    return Future.value([
      Organization(name: 'myOrg'),
    ]);
  }
}

class StubbedEmployeeServices implements EmployeeServices {
  @override
  Future<List<Employee>> getList() {
    return Future.value([
      Employee(
        id: 1,
        name: 'Carolina Bernardo',
        title: 'Fisioterapeuta',
        image: employeeImage1,
      ),
      Employee(
        id: 2,
        name: 'André Fernandes',
        title: 'Terapeuta da Fala',
        image: employeeImage2,
      ),
      Employee(
        id: 3,
        name: 'Ilona Tóth',
        title: 'Fisioterapeuta',
        image: employeeImage3,
      ),
    ]);
  }

  @override
  void login(EmployeePin employeePin,
      {void Function(Token result) onSuccess, void Function() onFailure}) {
    onSuccess(Token(token: 'stubbed employee token'));
  }

  @override
  void logout() {}
}

class StubbedLoginServices implements LoginServices {
  @override
  void login(Credentials credentials, {onSuccess, onFailure}) {
    onSuccess(Token(token: 'stubbed token'));
  }
}
