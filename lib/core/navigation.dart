import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cresce_flutter_app/core/core.dart';

class NavigationManager {
  void navigateToPage<TPage extends Widget>(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => context.get<TPage>()),
      (Route<dynamic> route) => false,
    );
  }
}
