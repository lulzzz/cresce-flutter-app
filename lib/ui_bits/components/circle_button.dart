import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter/widgets.dart';

class BitCircleButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final BitAnimation animation;
  final IconData iconData;

  const BitCircleButton({
    this.label,
    this.onTap,
    this.iconData,
    this.animation = const BitNoAnimation(),
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final buttonTheme = theme.floatingActionButtonTheme;
    final child = label != null ? _makeLabelText(theme) : _makeIcon(theme);

    return animation.wrapWidget(
      child: Material(
        shape: buttonTheme.shape,
        color: theme.primaryColor,
        shadowColor: buttonTheme.backgroundColor ?? theme.primaryColor,
        elevation: buttonTheme.elevation ?? 0.1,
        child: InkWell(
          borderRadius: context.borders.circular,
          onTap: () => onTap?.call(),
          child: Container(
            width: 60.0,
            height: 60.0,
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _makeIcon(ThemeData theme) => Icon(
        this.iconData,
        color: theme.textTheme.button.color,
        size: theme.textTheme.button.fontSize,
      );

  Widget _makeLabelText(ThemeData theme) =>
      Text(label, style: theme.textTheme.button);
}
