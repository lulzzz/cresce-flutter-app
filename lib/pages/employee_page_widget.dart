import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmployeePageWidget extends StatelessWidget {
  final String title;

  const EmployeePageWidget({Key key, this.title}) : super(key: key);

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
              child: EmployeeCarouselWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
