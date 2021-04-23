import 'dart:ui';

import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:equatable/equatable.dart';

class AppointmentServices implements EntityListGateway<Appointment> {
  HttpGet _httpGet;

  AppointmentServices(this._httpGet);

  @override
  Future<List<Appointment>> getList() {
    return _httpGet.getList<Appointment>(
      url: 'api/v1/appointments/',
      deserialize: Appointment(),
    );
  }

  Future<List<Meeting>> getMeetings() async {
    var result = await getList();
    print(result);
    return result.cast<Meeting>();
  }
}

// ignore: must_be_immutable
class Appointment extends Equatable implements Deserialize, Meeting {
  Appointment({
    this.eventName,
    this.from,
    this.to,
    this.background,
    this.recurrence,
    this.isAllDay,
    this.data,
    this.id,
  });

  @override
  Object deserialize(Map<String, dynamic> data) {
    return Appointment(
      id: data['id'],
      eventName: data['eventName'],
      from: DateTime.parse(data['from']),
      to: DateTime.parse(data['to']),
      background:
          Color(int.parse(data['color'].toString().substring(2), radix: 16)),
      isAllDay: false,
      recurrence: data['recurrence'] == null
          ? null
          : WeeklyRecurrence(
              startDate: DateTime.parse(data['recurrence']['start']),
              endDate: DateTime.parse(data['recurrence']['end']),
              weekDays: parseWeekDays(data['recurrence']['weekDays']),
            ),
    );
  }

  List<WeekDay> parseWeekDays(List<dynamic> data) {
    return data.map((e) {
      switch (e) {
        case 'MONDAY':
          return WeekDay.monday;
        case 'TUESDAY':
          return WeekDay.tuesday;
        case 'WEDNESDAY':
          return WeekDay.wednesday;
        case 'THURSDAY':
          return WeekDay.thursday;
        case 'FRIDAY':
          return WeekDay.friday;
        case 'SATURDAY':
          return WeekDay.saturday;
        case 'SUNDAY':
          return WeekDay.sunday;
      }
    }).toList();
  }

  int id;
  Color background;
  Object data;
  String eventName;
  DateTime from;
  bool isAllDay;
  Recurrence recurrence;
  DateTime to;
  Meeting copy({DateTime from, DateTime to}) {
    // TODO: implement copy
    throw UnimplementedError();
  }

  List<Object> get props => [
        recurrence?.toString(),
        background,
        id,
        eventName,
        from,
        to,
        data,
        isAllDay,
      ];
}
