import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

abstract class LoadingStopper {
  void stopLoading();
}

class BitPrimaryButton extends StatefulWidget {
  final String label;
  final void Function(LoadingStopper) onTap;
  final BitAnimation animation;

  const BitPrimaryButton({
    this.label,
    this.onTap,
    this.animation = const BitNoAnimation(),
  });

  @override
  _BitPrimaryButtonState createState() => _BitPrimaryButtonState();
}

class _BitPrimaryButtonState extends State<BitPrimaryButton>
    implements LoadingStopper {
  final Field<bool> _loading = Field.asBool();

  double _getTextWidth(BuildContext context) =>
      context.getTextWidth(widget.label, context.theme.textTheme.button) + 20;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final buttonTheme = theme.floatingActionButtonTheme;

    return widget.animation.wrapWidget(
      child: Material(
        shape: buttonTheme.shape,
        color: theme.primaryColor,
        shadowColor: buttonTheme.backgroundColor ?? theme.primaryColor,
        elevation: buttonTheme.elevation ?? 0.1,
        child: InkWell(
          borderRadius: context.borders.circular,
          onTap: () {
            _resetLoadingOnTimeout();
            _loading.setValue(true);
            widget.onTap?.call(this);
          },
          child: Container(
            width: _getTextWidth(context),
            height: 40.0,
            alignment: Alignment.center,
            child: BitObservable(
              field: _loading,
              buildByState: {
                true: BitLoading(),
                false: Text(
                  widget.label,
                  style: theme.textTheme.button,
                ),
              },
            ),
          ),
        ),
      ),
    );
  }

  void _resetLoadingOnTimeout() {
    Future.delayed(
      const Duration(seconds: 30),
      () => stopLoading(),
    );
  }

  @override
  void stopLoading() => _loading.setValue(false);
}
