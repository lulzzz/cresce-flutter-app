import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cresce_flutter_app/core/core.dart';

class PageMessages {
  final String title;

  PageMessages(this.title);
}

abstract class PageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageMessages messages = context.locations;
    return Scaffold(
      appBar: AppBar(title: Text(messages.title)),
      drawer: buildSideMenu(context),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: [
              buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context);

  Widget buildSideMenu(BuildContext context) => null;
}
