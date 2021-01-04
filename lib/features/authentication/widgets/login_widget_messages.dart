import 'package:cresce_flutter_app/features/features.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui_bits/ui_bits.dart';

class LoginWidgetMessages {
  final String loginLabel;
  final String userFieldLabel;
  final String passwordFieldLabel;

  FieldLabels get userField => FieldLabels(
        label: userFieldLabel,
        icon: FontAwesomeIcons.solidUserCircle,
      );

  FieldLabels get passwordField => FieldLabels(
        label: passwordFieldLabel,
        icon: FontAwesomeIcons.lock,
      );

  const LoginWidgetMessages({
    this.loginLabel = 'LOGIN',
    this.userFieldLabel = 'User',
    this.passwordFieldLabel = 'Password',
  });

  factory LoginWidgetMessages.make(AppLocalizations localization) {
    return LoginWidgetMessages(
      userFieldLabel: localization.user,
      passwordFieldLabel: localization.password,
      loginLabel: localization.login,
    );
  }
}
