import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/widgets.dart';

class DurationPrompt extends StatelessWidget {
  final void Function(Duration duration) onSelect;
  final String label;

  const DurationPrompt({
    Key key,
    this.onSelect,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PromptContainerWidget(
      child: BitDurationPicker(
        min: const Duration(minutes: 30),
        max: const Duration(hours: 4),
        onChangeEnd: (duration) => onSelect?.call(duration),
      ),
      label: label,
    );
  }
}
