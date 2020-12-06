import 'package:cresce_flutter_app/features/authentication/authentication.dart';
import 'package:cresce_flutter_app/features/authentication/widgets/login_card_widget.dart';
import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

class LoginWidget extends StatefulWidget {
  final LoginWidgetLabels labels;
  final LoginWidgetLabels messages;
  final void Function(LoginResultDto credentialsDto) onSuccess;
  final LoginServices services;

  const LoginWidget({
    Key key,
    this.labels,
    this.onSuccess,
    this.services,
    this.messages = const LoginWidgetLabels(),
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final AnimationOrchestrator loginCardInputs = AnimationOrchestrator();
  final AnimationOrchestrator flipAnimation = AnimationOrchestrator();

  @override
  void initState() {
    super.initState();

    flipAnimation.startAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return FlipAnimation(
      duration: const Duration(milliseconds: 700),
      onComplete: loginCardInputs,
      startAfter: flipAnimation.delayedInMillis(150),
      child: LoginCardWidget(
        messages: widget.messages,
        startInputAnimationsAfter: loginCardInputs.delayedInMillis(500),
        onCredentialsSubmit: submitCredentials,
      ),
    );
  }

  void submitCredentials(CredentialsDto credentials) {
    (widget.services ?? get<LoginServices>()).login(
      credentials,
      successCallback: widget.onSuccess,
    );
  }
}
