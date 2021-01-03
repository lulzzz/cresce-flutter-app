import 'package:cresce_flutter_app/features/authentication/authentication_module.dart';
import 'package:cresce_flutter_app/features/core/core.dart';
import 'package:cresce_flutter_app/features/core/core_module.dart';
import 'package:cresce_flutter_app/features/employees/employees_module.dart';
import 'package:cresce_flutter_app/features/http_requests/http_module.dart';
import 'package:cresce_flutter_app/features/organizations/organizations_module.dart';
import 'package:cresce_flutter_app/pages/pages_module.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void _stubOverrideDependencies(ServiceLocator locator) {}

Provider<ServiceLocator> wrapWithProvider({
  Widget app,
  void Function(ServiceLocator) override,
}) {
  return Provider<ServiceLocator>(
    create: (_) => makeServiceLocator(override: override),
    child: app,
  );
}

ServiceLocator makeServiceLocator({
  String authority = 'https://cresce.azurewebsites.net/',
  void Function(ServiceLocator) override = _stubOverrideDependencies,
}) {
  var locator = ServiceLocator();

  locator.registerModule(PageWidgetsModule());
  locator.registerModule(HttpModule(authority));
  locator.registerModule(AuthenticationModule());
  locator.registerModule(EmployeesModule());
  locator.registerModule(OrganizationsModule());
  locator.registerModule(CoreModule());

  override?.call(locator);
  return locator;
}

extension BuildContextExtensions on BuildContext {
  T get<T>() {
    var locator = Provider.of<ServiceLocator>(this, listen: false);
    return locator<T>();
  }

  void navigateTo<TPage extends Widget>() {
    var navigator = get<NavigationManager>();
    navigator.navigateToPage<TPage>(this);
  }
}
