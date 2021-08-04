import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_model.dart';
import '../../tester_extensions.dart';

void main() {
  group(EntityCarouselWidget, () {
    testWidgets('on build fetch entities', (tester) async {
      await _pumpWidget(tester, (_) {});

      expect(find.byType(BitCarousel), findsOneWidget);
      expect(find.byType(BitThumbnail), findsNWidgets(2));
    });
    testWidgets('tapping a card selects the entity', (tester) async {
      var entity;
      await _pumpWidget(tester, (e) => entity = e);

      await tester.tapFirstCard<TestModel>();

      expect(entity, isNotNull);
    });
    testWidgets('tapping a card without callback doesnt fail', (tester) async {
      await _pumpWidget(tester, null);

      await tester.tapFirstCard<TestModel>();
    });
  });
}

Future _pumpWidget(
  WidgetTester tester,
  void Function(TestModel entity) onSelect,
) async {
  await tester.pumpWidgetInApp(EntityCarouselWidget<TestModel>(
    onSelect: onSelect,
  ));
  await tester.pumpAndSettle();
}
