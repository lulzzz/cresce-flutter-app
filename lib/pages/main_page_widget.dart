import 'package:cresce_flutter_app/features/appointments/services/appointment_services.dart';
import 'package:cresce_flutter_app/pages/page_widget.dart';
import 'package:cresce_flutter_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

class MainPageWidget extends PageWidget {
  @override
  Widget buildBody(BuildContext context) {
    return Expanded(
      child: BitCalendar(
        startHour: 8,
        endHour: 20,
        meetings: context.get<AppointmentServices>().getMeetings(),
        onTap: (slot) {},
      ),
    );
  }

  @override
  Widget buildSideMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: context.theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildTile(String data, Widget widget) {
    return ListTile(
      title: Text(data),
      onTap: () {},
    );
  }
}
