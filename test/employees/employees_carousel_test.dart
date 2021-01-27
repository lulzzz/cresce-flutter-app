import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_bits/ui_bits.dart';

import '../tester_extensions.dart';

void main() {
  group(EmployeeCarouselWidget, () {
    testWidgets('on build fetch employees', (tester) async {
      await _pumpWidget(tester);

      expect(find.byType(BitCarousel), findsOneWidget);
      expect(find.byType(BitThumbnail), findsOneWidget);
    });
    testWidgets('tapping an employee displays PinPad', (tester) async {
      await _pumpWidget(tester);

      await tester.tap(find.byType(BitThumbnail));

      expect(find.byType(BitPinPad), findsOneWidget);
    });
  });
}

Future _pumpWidget(WidgetTester tester) async {
  await tester.pumpWidgetInApp(
    EmployeeCarouselWidget(),
  );
  await tester.pumpAndSettle();
}
