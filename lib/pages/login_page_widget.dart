import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/pages/employee_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cresce_flutter_app/service_configuration.dart';

class LoginPageWidget extends StatelessWidget {
  final String title;

  const LoginPageWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25.0),
              child: LoginWidget(
                messages: LoginWidgetMessages.make(context.locations),
                onSuccess: (result) {
                  context.navigateTo<EmployeePageWidget>();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
