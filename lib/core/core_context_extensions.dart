import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
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

  String getLanguage() => Localizations.localeOf(this).languageCode;

  String formatDate(DateTime date) =>
      DateFormat.yMd(this.getLanguage()).format(date);

  String formatDateTime(DateTime date) =>
      DateFormat.yMd(this.getLanguage()).add_jm().format(date);

  String formatWeekday(DateTime date) =>
      DateFormat.E(this.getLanguage()).format(date);

  String formatDuration(Duration duration) =>
      DurationLocations().formatDuration(duration ?? const Duration());

  double getScreenWidth() => MediaQuery.of(this).size.width;
}
