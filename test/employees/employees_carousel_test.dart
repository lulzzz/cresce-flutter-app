import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_bits/ui_bits.dart';

import '../tester_extensions.dart';

void main() {
  group(EmployeeCarouselWidget, () {
    testWidgets('on build fetch employees', (tester) async {
      await _pumpWidget(tester, (_) {});

      expect(find.byType(BitCarousel), findsOneWidget);
      expect(find.byType(BitThumbnail), findsNWidgets(2));
    });
    testWidgets('tapping an employee selects the employee', (tester) async {
      var employee;
      await _pumpWidget(tester, (e) => employee = e);

      await selectFirstEmployee(tester);

      expect(employee, isNotNull);
    });
  });
}

Future selectFirstEmployee(WidgetTester tester) async {
  await tester.tap(find.byType(BitThumbnail).first);
  await tester.pump();
}

Future _pumpWidget(
    WidgetTester tester, void Function(Employee employee) onSelect) async {
  await tester.pumpWidgetInApp(
    EmployeeCarouselWidget(onSelect: onSelect),
  );
  await tester.pumpAndSettle();
}
