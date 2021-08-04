import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class BitLoading extends StatelessWidget {
  final BitScheme scheme;

  BitLoading({
    this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = scheme ?? BitScheme.primary(context);
    return Container(
      child: Loading(
        indicator: BallPulseIndicator(),
        color: colorScheme.primaryColor,
      ),
    );
  }
}

class BitScheme {
  final Color primaryColor;
  final Color secondaryColor;

  const BitScheme._({
    this.primaryColor,
    this.secondaryColor,
  });

  factory BitScheme.primary(BuildContext context) {
    return BitScheme._(
      primaryColor: context.theme.backgroundColor,
      secondaryColor: context.theme.primaryColor,
    );
  }

  factory BitScheme.secondary(BuildContext context) {
    return BitScheme._(
      primaryColor: context.theme.primaryColor,
      secondaryColor: context.theme.backgroundColor,
    );
  }
}
