import 'package:cresce_flutter_app/core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

extension BuildContextExtensions on BuildContext {
  T get<T>() {
    var locator = Provider.of<ServiceLocator>(this, listen: false);
    return locator<T>();
  }

  AppLocalizations get locations =>
      Localizations.of<AppLocalizations>(this, AppLocalizations);

  void navigateTo<TPage extends Widget>() {
    var navigator = get<NavigationManager>();
    navigator.navigateToPage<TPage>(this);
  }
}
