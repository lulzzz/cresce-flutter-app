import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('null future image should not fail', (tester) async {
    await tester.pumpWidget(CircleImageWidget(
      width: 30,
      image: null,
    ));
    await tester.pumpAndSettle();

    expect(find.byType(CircleImageWidget), findsOneWidget);
  });
  testWidgets('null image should not fail', (tester) async {
    await tester.pumpWidget(CircleImageWidget(
      width: 30,
      image: Future.value(null),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(CircleImageWidget), findsOneWidget);
  });
  testWidgets('null image should not fail', (tester) async {
    await tester.pumpWidget(CircleImageWidget(
      width: 30,
      image: Future.value(BitImageBase64(null)),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(CircleImageWidget), findsOneWidget);
  });
}
