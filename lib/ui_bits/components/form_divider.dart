import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BitMediumPadding(
      options: BitEdgeInsetsOptions.combine([
        BitEdgeInsetsOptions.bottom,
        BitEdgeInsetsOptions.top,
      ]),
      child: Divider(color: context.theme.primaryColor),
    );
  }
}
