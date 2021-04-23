import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(BitCalendar, () {
    test('meeting dates equals slot datetime when dates are the same', () {
      var slot = CalendarSlot(
        dateTime: DateTime(2021, 1, 1),
        meeting: Meeting(
          from: DateTime(2021, 1, 1, 10),
          to: DateTime(2021, 1, 1, 12),
        ),
      );

      var currentMeeting = slot.meeting;

      expect(currentMeeting.from, DateTime(2021, 1, 1, 10));
      expect(currentMeeting.to, DateTime(2021, 1, 1, 12));
    });

    test('meeting datetimes only copies date from slot', () {
      var slot = CalendarSlot(
        dateTime: DateTime(2021, 1, 2, 8),
        meeting: Meeting(
          from: DateTime(2021, 1, 1, 10),
          to: DateTime(2021, 1, 1, 12),
        ),
      );

      var currentMeeting = slot.meeting;

      expect(currentMeeting.from, DateTime(2021, 1, 2, 10));
      expect(currentMeeting.to, DateTime(2021, 1, 2, 12));
    });

    test('meeting gets date from slot date when dates are not the same', () {
      var slot = CalendarSlot(
        dateTime: DateTime(2021, 1, 3),
        meeting: Meeting(
          from: DateTime(2021, 1, 1, 10),
          to: DateTime(2021, 1, 1, 12),
        ),
      );

      var currentMeeting = slot.meeting;

      expect(currentMeeting.from, DateTime(2021, 1, 3, 10));
      expect(currentMeeting.to, DateTime(2021, 1, 3, 12));
    });
  });
}
