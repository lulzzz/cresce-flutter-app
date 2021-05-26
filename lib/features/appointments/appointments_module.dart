import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/appointments/appointments.dart';
import 'package:cresce_flutter_app/features/appointments/services/appointment_services.dart';

class AppointmentsModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory<AppointmentServices>(() {
      return AppointmentServices(locator.get<HttpGet>());
    });
    locator.registerFactory<EntityListGateway<Appointment>>(() {
      return locator.get<AppointmentServices>();
    });

    locator.registerProvider(CreateAppointmentProvider());
    locator.registerFactory<CreateAppointmentPromptProvider>(
      () => locator.get<CreateAppointmentProvider>(),
    );
    locator.registerFactory<CreateAppointmentCleaner>(
      () => locator.get<CreateAppointmentProvider>(),
    );
    locator.registerFactory<IBuildState<CreateAppointmentState>>(
      () => locator.get<CreateAppointmentProvider>(),
    );
  }
}
