import 'package:cresce_flutter_app/app.dart';
import 'package:cresce_flutter_app/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_bits/ui_bits.dart';

import 'authentication/login_widget_test.dart';
import 'employees/employee_pin_pad_test.dart';
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
    testWidgets('on entering employee pin navigate to main page',
        (WidgetTester tester) async {
      await tester.pumpApp();

      await enterValidLogin(tester);
      await selectFirstEmployee(tester);
      await enterValidPin(tester);

      expect(find.byType(MainPageWidget), findsOneWidget);
      await tester.waitForAnimationsToSettle();
    });
  });
}
