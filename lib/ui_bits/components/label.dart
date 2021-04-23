import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';

class BitLabel extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final BitTextStyles style;

  const BitLabel({
    Key key,
    this.label,
    this.onTap,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onTap == null
        ? buildText()
        : InkWell(onTap: onTap, child: buildText());
  }

  BitText buildText() => BitText(label, style: style ?? BitTextStyles.h3);
}
