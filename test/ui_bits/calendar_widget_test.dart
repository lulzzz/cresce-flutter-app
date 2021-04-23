import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() {
  testWidgets('', (tester) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: [
        SfGlobalLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: BitCalendar(),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(BitCalendar), findsOneWidget);
    await tester.pump(Duration(seconds: 1));
  });
}
