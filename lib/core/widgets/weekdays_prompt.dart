import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/widgets.dart';

class WeekDaysPrompt extends StatelessWidget {
  final void Function(List<WeekDay> weekdays) onChange;
  final String label;

  const WeekDaysPrompt({Key key, this.onChange, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PromptContainerWidget(
      child: WeekDaysWidget(onChange: onChange),
      label: label,
    );
  }
}
