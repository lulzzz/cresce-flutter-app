import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tester_extensions.dart';
import '../ui_bits/duration_test.dart';

void main() {
  EquatableConfig.stringify = true;

  group(CreateAppointmentWidget, () {
    testWidgets('create appointment widget displays services', (tester) async {
      await tester.pumpWidgetInApp(CreateAppointmentWidget());

      await _expectToPromptService(tester);
    });

    testWidgets('tapping service card displays customers', (tester) async {
      await tester.pumpWidgetInApp(CreateAppointmentWidget());

      await tester.tapFirstCard<Service>();

      await _expectToPromptCustomer(tester);
    });

    testWidgets('tapping selected service prompts for Service', (tester) async {
      await tester.pumpWidgetInApp(CreateAppointmentWidget());

      await tester.tapFirstCard<Service>();
      await tester.tapCard(label: 'test service 1');

      await _expectToPromptService(tester);
    });

    testWidgets('tapping customer card displays duration picker',
        (tester) async {
      await tester.pumpWidgetInApp(CreateAppointmentWidget());

      await tester.tapFirstCard<Service>();
      await tester.tapFirstCard<Customer>();

      await _expectToPromptDuration(tester);
    });

    testWidgets('tapping selected customer prompts for Customer',
        (tester) async {
      await tester.pumpWidgetInApp(CreateAppointmentWidget());

      await tester.tapFirstCard<Service>();
      await tester.tapFirstCard<Customer>();
      await tester.tapCard(label: 'test customer 1');

      await _expectToPromptCustomer(tester);
    });

    testWidgets('picking a duration displays week days', (tester) async {
      await tester.pumpWidgetInApp(CreateAppointmentWidget());

      await setAllFields(tester);

      await _expectToPromptWeekdays(tester);
    });

    testWidgets('tapping selected duration prompts for Duration',
        (tester) async {
      await tester.pumpWidgetInApp(CreateAppointmentWidget());

      await setAllFields(tester);
      await tester.tap(find.byKey(Key('appointment_picked_duration')));
      await tester.pump();

      await _expectToPromptDuration(tester);
    });

    testWidgets('picking a duration displays plus button', (tester) async {
      await tester.pumpWidgetInApp(CreateAppointmentWidget());

      await setAllFields(tester);

      await _expectToPromptWeekdays(tester);
      expectToFind(find.byIcon(FontAwesomeIcons.calendarPlus));
    });

    testWidgets('tapping plus button stores the appointment', (tester) async {
      var appointmentStorage = FakeAppointmentStorage();
      await tester.pumpWidgetInApp(
        CreateAppointmentWidget(),
        override: (locator) {
          locator.override<AppointmentStorage>(appointmentStorage);
        },
      );

      await setAllFields(tester);
      await tester.tap(find.byIcon(FontAwesomeIcons.calendarPlus));
      await tester.pump();

      expect(appointmentStorage.wasStored, true);
    });
  });
}

class FakeAppointmentStorage implements AppointmentStorage {
  var wasStored = false;

  @override
  void store() => wasStored = true;
}

Future<void> setAllFields(WidgetTester tester) async {
  await tester.tapFirstCard<Service>();
  await tester.tapFirstCard<Customer>();
  await dragSliderRight(tester);
}

Future<void> _expectToPromptWeekdays(WidgetTester tester) async {
  expectNotToFind(find.byGenericType<EntityCarouselWidget<Service>>());
  expectNotToFind(find.byGenericType<EntityCarouselWidget<Customer>>());
  expectNotToFind(find.byGenericType<BitDurationPicker>());
  expectToFindType<WeekDaysWidget>();
  await tester.waitForAnimationsToSettle();
}

Future<void> _expectToPromptDuration(WidgetTester tester) async {
  expectNotToFind(find.byGenericType<EntityCarouselWidget<Service>>());
  expectNotToFind(find.byGenericType<EntityCarouselWidget<Customer>>());
  expectToFindType<BitDurationPicker>();
  await tester.waitForAnimationsToSettle();
}

Future<void> _expectToPromptCustomer(WidgetTester tester) async {
  expectNotToFind(find.byGenericType<EntityCarouselWidget<Service>>());
  expectToFind(find.byGenericType<EntityCarouselWidget<Customer>>());
  await tester.waitForAnimationsToSettle();
}

Future<void> _expectToPromptService(WidgetTester tester) async {
  expectToFind(find.byGenericType<EntityCarouselWidget<Service>>());
  expectNotToFind(find.byGenericType<EntityCarouselWidget<Customer>>());
  await tester.waitForAnimationsToSettle();
}
