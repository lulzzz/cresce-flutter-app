import 'package:cresce_flutter_app/pages/login_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:ui_bits/ui_bits.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: PurpleThemeFactory().makeTheme(),
      home: LoginPageWidget(title: 'Flutter Demo Home Page'),
    );
  }
}
