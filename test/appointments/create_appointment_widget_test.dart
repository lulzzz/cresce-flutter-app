import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import '../tester_extensions.dart';

void main() {
  group(CreateAppointmentWidget, () {
    testWidgets('create appointment widget displays services', (tester) async {
      await tester.pumpWidgetInApp(CreateAppointmentWidget());

      expectToFind(find.byGenericType<EntityCarouselWidget<Service>>());
      expectNotToFind(find.byGenericType<EntityCarouselWidget<Customer>>());
    });
    testWidgets('tapping service card displays customers', (tester) async {
      await tester.pumpWidgetInApp(CreateAppointmentWidget());

      await tester.tapFirstCard<Service>();

      expectNotToFind(find.byGenericType<EntityCarouselWidget<Service>>());
      expectToFind(find.byGenericType<EntityCarouselWidget<Customer>>());
      await tester.waitForAnimationsToSettle();
    });
    testWidgets('tapping customer card displays duration picker',
        (tester) async {
      print('start');
      await tester.pumpWidgetInApp(CreateAppointmentWidget());

      await tester.tapFirstCard<Service>();
      expectToFind(find.byGenericType<EntityCarouselWidget<Customer>>());
      await tester.tapFirstCard<Customer>();

      expectNotToFind(find.byGenericType<EntityCarouselWidget<Service>>());
      expectNotToFind(find.byGenericType<EntityCarouselWidget<Customer>>());
      expectToFindType<BitDurationPicker>();
      await tester.waitForAnimationsToSettle();
    });
  });
}
