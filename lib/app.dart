import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ui_bits/ui_bits.dart';

Widget makeApp({
  Widget home,
  String webApiUrl,
  void Function(ServiceLocator) overrideDependencies,
}) {
  return MyApp(
    home: home,
    webApiUrl: webApiUrl,
    overrideDependencies: overrideDependencies,
  );
}

class MyApp extends StatelessWidget {
  final Widget home;
  final void Function(ServiceLocator) overrideDependencies;
  final String webApiUrl;

  const MyApp({
    this.home,
    this.overrideDependencies,
    this.webApiUrl,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    var themeFactory = ThemeFactory();
    return wrapWithProvider(
      webApiUrl: webApiUrl,
      override: overrideDependencies,
      app: Builder(
        builder: (context) {
          return MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              SfGlobalLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: themeFactory.makeBlueTheme(),
            home: themeFactory.makeHome(
              child: home ?? context.get<LoginPageWidget>(),
            ),
          );
        },
      ),
    );
  }
}
