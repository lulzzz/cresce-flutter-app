import 'package:cresce_flutter_app/features/appointments/appointments.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import '../tester_extensions.dart';

void main() {
  group(AppointmentsCalendar, () {
    testWidgets('building calendar doesnt fail', (tester) async {
      tz.initializeTimeZones();

      await tester.pumpWidgetInApp(Column(
        children: [
          BitCalendar(
            meetings: Future.value([]),
          ),
        ],
      ));
    });
  });
}
