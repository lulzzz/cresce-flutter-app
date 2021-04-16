import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/appointments/services/appointment_services.dart';

class AppointmentsModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory<AppointmentServices>(() {
      return AppointmentServices(
        locator.get<HttpGet>(),
      );
    });
    locator.registerFactory<EntityListGateway<Appointment>>(() {
      return AppointmentServices(
        locator.get<HttpGet>(),
      );
    });
  }
}
