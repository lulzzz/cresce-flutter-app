import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/pages/employee_page_widget.dart';
import 'package:cresce_flutter_app/pages/page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cresce_flutter_app/core/core.dart';

class LoginPageWidget extends PageWidget {
  @override
  Widget buildBody(BuildContext context) {
    return LoginWidget(
      messages: context.locations,
      onSuccess: (result) {
        context.navigateTo<EmployeePageWidget>();
      },
    );
  }
}
