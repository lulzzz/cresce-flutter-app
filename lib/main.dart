import 'package:cresce_flutter_app/pages/login_page_widget.dart';
import 'package:cresce_flutter_app/features/core/services_locator.dart';
import 'package:cresce_flutter_app/service_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_bits/ui_bits.dart';

void main() {
  runApp(makeApp());
}

Widget makeApp({
  Widget home,
  void Function(ServiceLocator) overrideDependencies,
}) {
  return MyApp(
    home: home,
    overrideDependencies: overrideDependencies,
  );
}

class MyApp extends StatelessWidget {
  final Widget home;
  final void Function(ServiceLocator) overrideDependencies;

  const MyApp({
    this.home,
    this.overrideDependencies,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    var themeFactory = ThemeFactory();
    return wrapWithProvider(
      override: overrideDependencies,
      app: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: themeFactory.makeBlueTheme(),
        home: themeFactory.makeHome(
          child: home ?? LoginPageWidget(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}
