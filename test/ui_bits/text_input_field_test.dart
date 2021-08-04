import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'tester_extensions.dart';

void main() {
  [
    (field) => makeTextInputField(field),
    (field) => makePasswordInputField(field),
  ].forEach((makeTestCase) {
    Future pumpWidget(WidgetTester tester, Field<String> field) async {
      await makeTestCase(field)['widget'](tester);
    }

    group('input: ${makeTestCase(null)['type']}', () {
      testWidgets('getting value from field returns what was entered',
          (tester) async {
        final Field<String> field = Field.asText();
        await pumpWidget(tester, field);

        await tester.enterText(find.byType(TextField), 'some text');

        expect(field.getValue(), 'some text');
      });

      testWidgets('when field is null entered value is present',
          (tester) async {
        final Field<String> field = null;
        await pumpWidget(tester, field);

        await tester.enterText(find.byType(TextField), 'some text');

        expect(find.text('some text'), findsOneWidget);
      });

      testWidgets('field use field initial value', (tester) async {
        final Field<String> field = Field.asText(initialValue: 'some value');

        await pumpWidget(tester, field);

        expect(field.getValue(), 'some value');
      });

      testWidgets('field is empty when initial value is null', (tester) async {
        final Field<String> field = Field.asText();

        await pumpWidget(tester, field);

        expect(field.getValue(), '');
      });
    });
  });
}

Map<String, dynamic> makeTextInputField(Field<String> field) {
  return {
    'type': BitInputTextField,
    'widget': (WidgetTester tester) {
      return tester.pumpApp(
        BitInputTextField(
          FieldLabels(
            label: 'myLabel',
            icon: Icons.add,
          ),
          field: field,
        ),
      );
    },
  };
}

Map<String, dynamic> makePasswordInputField(Field<String> field) {
  return {
    'type': BitInputPasswordField,
    'widget': (WidgetTester tester) {
      return tester.pumpApp(
        BitInputPasswordField(
          FieldLabels(
            label: 'myLabel',
            icon: Icons.add,
          ),
          field: field,
        ),
      );
    },
  };
}
