import 'package:cresce_flutter_app/features/features.dart';

import '../tester_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_bits/ui_bits.dart';

import 'login_services_test.dart';

void main() {
  group(LoginWidget, () {
    testWidgets('login with right user and password calls onSuccess',
        (tester) async {
      LoginResultDto result;

      await _pumpWidget(tester, onLoginCall: (resultDto) {
        result = resultDto;
      });

      await enterValidLogin(tester);

      expect(
        result,
        LoginResultDto(
          organizationUrl: 'someOrganizationUrl',
          token: 'myAuthToken',
        ),
      );
    });

    testWidgets('login with wrong user displays failure messsage',
        (tester) async {
      // TODO: manage failure: display failure message
    });
  });
}

Future enterValidLogin(WidgetTester tester) async {
  await _enterUser(tester, 'myUser');
  await _enterPassword(tester, 'myPass');
  await _tapLogin(tester);
}

Future _tapLogin(WidgetTester tester) async {
  await tester.tap(find.widgetWithText(
    PrimaryButton,
    LoginWidgetLabels().loginLabel,
  ));
}

Future _enterUser(WidgetTester tester, String value) async {
  await tester.enterText(
    find.widgetWithText(TextField, LoginWidgetLabels().userField.label),
    value,
  );
}

Future _enterPassword(WidgetTester tester, String value) async {
  await tester.enterText(
    find.widgetWithText(TextField, LoginWidgetLabels().passwordField.label),
    value,
  );
}

Future _pumpWidget(
  WidgetTester tester, {
  void Function(LoginResultDto result) onLoginCall,
}) {
  return tester.pumpWidgetInApp(
    LoginWidget(
      onSuccess: onLoginCall,
      services: makeLoginServices(),
    ),
  );
}
