import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui_bits/ui_bits.dart';

class LoginWidgetLabels {
  final String loginLabel;
  final FieldLabels userField;
  final FieldLabels passwordField;

  const LoginWidgetLabels({
    this.userField = const FieldLabels(
      label: 'User',
      icon: FontAwesomeIcons.solidUserCircle,
    ),
    this.passwordField = const FieldLabels(
      label: 'Password',
      icon: FontAwesomeIcons.lock,
    ),
    this.loginLabel = 'LOGIN',
  });
}
