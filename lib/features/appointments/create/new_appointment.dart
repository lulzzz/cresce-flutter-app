import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:equatable/equatable.dart';

class NewAppointment extends Equatable implements Serializable {
  final Service service;
  final Customer customer;
  final Duration duration;
  final List<WeekDay> weekDays;
  final DateTime date;

  NewAppointment({
    this.service,
    this.customer,
    this.duration,
    this.weekDays,
    this.date,
  });

  @override
  List<Object> get props => [service, customer, duration, weekDays, date];

  bool hasAllMandatoryFields() =>
      ![service, customer, duration].any((element) => element == null);

  @override
  String serialize(Encoder encoder) {
    return encoder.encode({
      'serviceId': service.id,
      'customerId': customer.id,
      'from': date.toUtc().toIso8601String(),
      'to': date.add(duration).toUtc().toIso8601String(),
    });
  }

  Map<String, dynamic> toMap() {
    return {
      "service": service,
      "customer": customer,
      "duration": duration,
      "weekDays": weekDays,
    };
  }
}
