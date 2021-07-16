import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/appointments/appointments.dart';
import 'package:cresce_flutter_app/features/appointments/services/appointment_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory<AppointmentServices>(() {
      return AppointmentServices(locator.get<HttpGet>());
    });
    locator.registerFactory<EntityListGateway<Appointment>>(() {
      return locator.get<AppointmentServices>();
    });
    locator.registerFactory<NewAppointmentStorage>(() {
      return locator.get<AppointmentServices>();
    });

    locator.registerProviderFactory(
      () => CreateAppointmentProvider(locator.get<NewAppointmentStorage>()),
    );
    locator.registerFactory<CreateAppointmentPromptProvider>(
      () => locator.get<CreateAppointmentProvider>(),
    );
    locator.registerFactory<CreateAppointmentCleaner>(
      () => locator.get<CreateAppointmentProvider>(),
    );
    locator.registerFactory<AppointmentStorage>(
      () => locator.get<CreateAppointmentProvider>(),
    );
    locator.registerFactory<BlocBase<NewAppointment>>(
      () => locator.get<CreateAppointmentProvider>(),
    );
  }
}
