import 'dart:math';

import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginWidget extends StatefulWidget {
  final LoginWidgetMessages messages;
  final void Function(Token credentialsDto) onSuccess;

  const LoginWidget({
    Key key,
    this.onSuccess,
    this.messages = const LoginWidgetMessages(),
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final AnimationOrchestrator trigger = AnimationOrchestrator();
  final Field<String> _errorMessageField = Field.asText();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var fields = _CredentialsFields();
    final deviceSize = MediaQuery.of(context).size;
    final cardWidth = min(deviceSize.width * 0.75, 360.0);

    return BitCard(
      animation: BitAnimations.flip(onComplete: trigger),
      width: cardWidth,
      children: <Widget>[
        BitInputTextField(
          FieldLabels(
            label: widget.messages.user,
            icon: FontAwesomeIcons.solidUserCircle,
          ),
          field: fields.user,
          animation: BitAnimations.width(animateAfter: trigger),
        ),
        SizedBox(height: context.sizes.small),
        BitInputPasswordField(
          FieldLabels(
            label: widget.messages.password,
            icon: FontAwesomeIcons.lock,
          ),
          field: fields.password,
          animation: BitAnimations.width(
            animateAfter: trigger.delayedExtraShort(context),
          ),
        ),
        SizedBox(height: context.sizes.small),
        Center(
          child: Column(
            children: [
              BitPrimaryButton(
                onTap: (loading) {
                  submitCredentials(
                    fields.toCredentialsDto(),
                    context,
                    loading,
                  );
                },
                label: widget.messages.login,
                animation: BitAnimations.scale(animateAfter: trigger),
              ),
              SizedBox(height: context.sizes.mediumSmall),
              BitObservable(
                field: _errorMessageField,
                builder: (value) {
                  if (value == null) return null;
                  return BitText(value, style: BitTextStyles.body2);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void submitCredentials(
    Credentials credentials,
    BuildContext context,
    LoadingStopper loading,
  ) {
    context.get<LoginServices>().login(
      credentials,
      onSuccess: widget.onSuccess,
      onFailure: () {
        loading.stopLoading();
        _errorMessageField.setValue('Unable to verify provided credentials');
      },
    );
  }
}

class _CredentialsFields {
  final Field<String> user = Field.asText();
  final Field<String> password = Field.asText();

  void dispose() {
    user.dispose();
    password.dispose();
  }

  Credentials toCredentialsDto() {
    return Credentials(
      user: user.getValue(),
      password: password.getValue(),
    );
  }
}
