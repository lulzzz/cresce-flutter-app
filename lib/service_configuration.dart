import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/pages/pages_module.dart';
import 'package:flutter/widgets.dart';

void _stubOverrideDependencies(ServiceLocator locator) {}

Widget wrapWithProvider({
  Widget app,
  void Function(ServiceLocator) override,
  String webApiUrl,
}) {
  return ServiceLocatorProvider(
    serviceLocator: makeServiceLocator(
      override: override,
      webApiUrl: webApiUrl,
    ),
    child: app,
  );
}

ServiceLocator makeServiceLocator({
  String webApiUrl = 'https://cresce.azurewebsites.net/',
  void Function(ServiceLocator) override = _stubOverrideDependencies,
}) {
  var locator = ServiceLocator();

  const localMode = String.fromEnvironment('local-mode');
  if (localMode == 'YES') {
    print('running in local mode');
    print('docker run -d -p 5000:80 --name cresce.api alienengineer/cresce');
    webApiUrl = 'http://localhost:5000/';
  }

  locator.registerModule(PageWidgetsModule());
  locator.registerModule(HttpModule(webApiUrl));
  locator.registerModule(AuthenticationModule());
  locator.registerModule(EmployeesModule());
  locator.registerModule(CustomersModule());
  locator.registerModule(ServicesModule());
  locator.registerModule(OrganizationsModule());
  locator.registerModule(AppointmentsModule());
  locator.registerModule(CoreModule());

  override?.call(locator);
  return locator;
}
