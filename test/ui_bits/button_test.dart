import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter_test/flutter_test.dart';

import 'tester_extensions.dart';

void main() {
  testWidgets('tapping button calls the given callback', (tester) async {
    var wasCalled = false;
    await tester.pumpApp(
      BitPrimaryButton(
        onTap: (loading) => wasCalled = true,
        label: 'myButton',
      ),
    );

    await tester.tap(find.byType(BitPrimaryButton));
    await tester.pump(const Duration(seconds: 60));

    expect(wasCalled, isTrue);
  });

  testWidgets('tapping button displays loading', (tester) async {
    await tester.pumpApp(
      BitPrimaryButton(
        label: 'myButton',
      ),
    );

    await tester.tap(find.byType(BitPrimaryButton));
    await tester.pump();

    expect(find.byType(BitLoading), findsOneWidget);
    await tester.pump(const Duration(seconds: 60));
  });
}
