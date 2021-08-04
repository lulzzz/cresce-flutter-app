import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                title: buildTitle(context, slot),
                content: Container(
                  width: context.getScreenWidth() - context.sizes.large * 2,
                  child: CreateAppointmentWidget(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Column buildTitle(BuildContext context, CalendarSlot slot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BitText(
          context.locations.newAppointment +
              ' | ' +
              context.formatDateTime(slot.dateTime),
          style: BitTextStyles.h3,
        ),
        Divider(color: context.theme.primaryColor),
      ],
    );
  }
}
