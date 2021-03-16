import 'dart:ui';

import 'package:cresce_flutter_app/core/core.dart';
import 'package:ui_bits/ui_bits.dart';

class AppointmentServices implements EntityListGateway<Appointment> {
  @override
  Future<List<Appointment>> getList() {
    throw UnimplementedError();
  }

  Future<List<Meeting>> getMeetings() async {
    var result = await getList();
    print(result);
    return result.cast<Meeting>();
  }
}

class Appointment extends Meeting implements Deserialize {
  Appointment({
    String eventName,
    DateTime from,
    DateTime to,
    Color background,
    Recurrence recurrence,
    bool isAllDay,
    Object data,
  }) : super(
          eventName: eventName,
          from: from,
          to: to,
          background: background,
          isAllDay: isAllDay,
          recurrence: recurrence,
          data: data,
        );

  @override
  Object deserialize(Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}
