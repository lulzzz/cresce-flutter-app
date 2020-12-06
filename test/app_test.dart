import 'package:cresce_flutter_app/employee_page_widget.dart';
import 'package:cresce_flutter_app/login_page_widget.dart';
import 'package:cresce_flutter_features/cresce_flutter_features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cresce_flutter_app/main.dart';
import 'package:ui_bits/ui_bits.dart';
import 'tester_extensions.dart';

void main() {
  group(MyApp, () {
    testWidgets('on app load ask for user login', (WidgetTester tester) async {
      await tester.pumpApp();

      expect(find.byType(LoginPageWidget), findsOneWidget);
    });

    testWidgets('on successful login navigate to employees page',
        (WidgetTester tester) async {
      await tester.pumpApp();

      await enterValidLogin(tester);

      expect(find.byType(EmployeePageWidget), findsOneWidget);
    });
  });
}

Future enterValidLogin(WidgetTester tester) async {
  await enterUser(tester, 'myUser');
  await enterPassword(tester, 'myPass');
  await tapLogin(tester);
  await tester.pumpAndSettle();
}

Future tapLogin(WidgetTester tester) async {
  await tester.tap(find.widgetWithText(
    PrimaryButton,
    LoginWidgetLabels().loginLabel,
  ));
}

Future enterUser(WidgetTester tester, String value) async {
  await tester.enterText(
    find.widgetWithText(TextField, LoginWidgetLabels().userField.label,),
    value,
  );
}

Future enterPassword(WidgetTester tester, String value) async {
  await tester.enterText(
    find.widgetWithText(TextField, LoginWidgetLabels().passwordField.label),
    value,
  );
}
