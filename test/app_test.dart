import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/main.dart';
import 'package:cresce_flutter_app/pages/employee_page_widget.dart';
import 'package:cresce_flutter_app/pages/login_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_bits/ui_bits.dart';

import 'employees/employees_carousel_test.dart';
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
      expect(find.byType(BitThumbnail), findsNWidgets(2));
      await tester.waitForAnimationsToSettle();
    });
    testWidgets('select an employee prompts for pin',
        (WidgetTester tester) async {
      await tester.pumpApp();

      await enterValidLogin(tester);
      await selectFirstEmployee(tester);

      expect(find.byType(EmployeePageWidget), findsOneWidget);
      expect(find.byType(BitPinPad), findsNWidgets(1));
      await tester.waitForAnimationsToSettle();
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
    BitPrimaryButton,
    LoginWidgetMessages().login,
  ));
}

Future enterUser(WidgetTester tester, String value) async {
  await tester.enterText(
    find.widgetWithText(
      TextField,
      LoginWidgetMessages().user,
    ),
    value,
  );
}

Future enterPassword(WidgetTester tester, String value) async {
  await tester.enterText(
    find.widgetWithText(TextField, LoginWidgetMessages().password),
    value,
  );
}
