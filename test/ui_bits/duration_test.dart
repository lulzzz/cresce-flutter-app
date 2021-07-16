import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tester_extensions.dart';

void main() {
  group(BitDurationPicker, () {
    testWidgets('rendering BitDurationPicker displays it', (tester) async {
      await pumpWidget(tester, BitDurationPicker());

      expectToFindType<BitDurationPicker>();
    });

    testWidgets('dragging slider selects a duration', (tester) async {
      Duration _duration;
      await pumpWidget(
        tester,
        BitDurationPicker(onChangeEnd: (duration) => _duration = duration),
      );

      await dragSliderRight(tester);

      expect(_duration, const Duration(hours: 13, minutes: 30));
    });
  });
}

Future<void> dragSliderRight(WidgetTester tester,
    {double xPosition = 50}) async {
  await tester.drag(find.byType(Slider), Offset(xPosition, 0));
  await tester.pump();
}

Future<void> pumpWidget(WidgetTester tester, BitDurationPicker picker) =>
    tester.pumpWidget(MaterialApp(home: Scaffold(body: picker)));
