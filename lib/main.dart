import 'package:cresce_flutter_app/pages/login_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_bits/ui_bits.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    var themeFactory = ThemeFactory();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeFactory.makeBlueTheme(),
      home: themeFactory.makeHome(
        child: LoginPageWidget(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
