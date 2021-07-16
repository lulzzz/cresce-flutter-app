import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:equatable/equatable.dart';

class NewAppointment extends Equatable {
  final Service service;
  final Customer customer;
  final Duration duration;
  final List<WeekDay> weekDays;

  NewAppointment({
    this.service,
    this.customer,
    this.duration,
    this.weekDays,
  });

  @override
  List<Object> get props => [service, customer, duration, weekDays];

  bool hasAllMandatoryFields() =>
      ![service, customer, duration].any((element) => element == null);
}
