import 'dart:math';
import 'package:cresce_flutter_app/features/cresce_flutter_features.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

class LoginCardWidget extends StatefulWidget {
  final Function(CredentialsDto) onCredentialsSubmit;
  final LoginWidgetLabels messages;
  final AnimationRegistry startInputAnimationsAfter;

  const LoginCardWidget({
    this.onCredentialsSubmit,
    this.messages,
    this.startInputAnimationsAfter = const StubRegistry(),
  });

  @override
  _LoginCardWidgetState createState() => _LoginCardWidgetState();
}

class _LoginCardWidgetState extends State<LoginCardWidget> {
  final _CredentialsFields fields = _CredentialsFields();

  @override
  void dispose() {
    super.dispose();
    fields.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final cardWidth = min(deviceSize.width * 0.75, 360.0);
    const cardPadding = 16.0;
    final textFieldWidth = cardWidth - cardPadding * 2;

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              width: 1.2,
              color: context.theme.primaryColor,
            ),
          ),
          padding: EdgeInsets.only(
            left: cardPadding,
            right: cardPadding,
            bottom: cardPadding,
            top: cardPadding + 10,
          ),
          width: cardWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              WidthAnimation(
                duration: const Duration(milliseconds: 1150),
                animateAfter: widget.startInputAnimationsAfter,
                width: textFieldWidth,
                child: TextInputField(
                  widget.messages.userField,
                  field: fields.user,
                ),
              ),
              SizedBox(height: 10),
              WidthAnimation(
                duration: const Duration(milliseconds: 1150),
                animateAfter:
                    widget.startInputAnimationsAfter.delayedInMillis(150),
                width: textFieldWidth,
                child: PasswordInputField(
                  widget.messages.passwordField,
                  field: fields.password,
                  animateAfter:
                      widget.startInputAnimationsAfter.delayedInMillis(300),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ScaleAnimation(
                  duration: const Duration(milliseconds: 1150),
                  animateAfter: widget.startInputAnimationsAfter,
                  child: PrimaryButton(
                    onTap: () =>
                        widget.onCredentialsSubmit(fields.toCredentialsDto()),
                    label: widget.messages.loginLabel,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CredentialsFields {
  final Field<String> user = Field<String>();
  final Field<String> password = Field<String>();

  void dispose() {
    user.dispose();
    password.dispose();
  }

  CredentialsDto toCredentialsDto() {
    return CredentialsDto(
      user: user.getValue(),
      password: password.getValue(),
    );
  }
}
