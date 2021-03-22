import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

class AppointmentsCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BitCalendar(
        startHour: 8,
        endHour: 20,
        meetings: context.get<AppointmentServices>().getMeetings(),
        onTap: (slot) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: BitText(
                  context.locations.newAppointment,
                  style: BitTextStyles.h3,
                ),
                content: Container(
                  width: MediaQuery.of(context).size.width -
                      context.sizes.large * 2,
                  child: Padding(
                    padding: EdgeInsets.all(context.sizes.large),
                    child: CreateAppointmentWidget(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
