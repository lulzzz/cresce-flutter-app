import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/widgets.dart';

class PromptContainerWidget extends StatelessWidget {
  final String label;
  final Widget child;

  const PromptContainerWidget({Key key, this.label, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BitMediumPadding(
            child: BitText(label, style: BitTextStyles.h4),
            options: BitEdgeInsetsOptions.bottom,
          ),
          child,
        ],
      ),
    );
  }
}
