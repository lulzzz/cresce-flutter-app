import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension TesterExtensions on WidgetTester {
  Future pumpApp(Widget child) async {
    var factory = ThemeFactory();
    await this.pumpWidget(
      MaterialApp(
        theme: factory.makeBlueTheme(),
        home: Scaffold(
          body: factory.makeHome(child: child),
        ),
      ),
    );
    await this.pumpAndSettle();
  }
}
