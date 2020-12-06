import 'package:cresce_flutter_app/employee_page_widget.dart';
import 'package:cresce_flutter_features/cresce_flutter_features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPageWidget extends StatelessWidget {
  final String title;

  LoginPageWidget({Key key, this.title}) : super(key: key);

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
                onSuccess: (result) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EmployeePageWidget(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
