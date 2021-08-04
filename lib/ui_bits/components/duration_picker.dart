import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter/widgets.dart';

class DurationLocations {
  const DurationLocations();

  String formatDuration(Duration duration) {
    return "${duration.inHours}h:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}m";
  }
}

class BitDurationPicker extends StatefulWidget {
  final Field<Duration> field;
  final Duration min;
  final Duration max;
  final DurationLocations location;
  final void Function(Duration) onChangeEnd;

  BitDurationPicker({
    this.field,
    this.min = const Duration(),
    this.max = const Duration(hours: 24),
    this.location = const DurationLocations(),
    this.onChangeEnd,
  });

  @override
  _BitDurationPickerState createState() => _BitDurationPickerState();
}

class _BitDurationPickerState extends State<BitDurationPicker> {
  final Field<int> _valueField = Field.asInt();

  @override
  void initState() {
    super.initState();
    _valueField.setValue(widget.min.inMinutes.toInt());
    widget.field?.setValue(_getDuration(widget.min.inMinutes.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return BitObservable<int>(
      field: _valueField,
      builder: (current) => Slider(
        value: current.toDouble(),
        min: widget.min.inMinutes.toDouble(),
        max: widget.max.inMinutes.toDouble(),
        divisions: (widget.max.inMinutes - widget.min.inMinutes) ~/ 30,
        label: widget.location.formatDuration(_getDuration(current)),
        onChanged: (double value) {
          _valueField.setValue(value.toInt());
          widget.field?.setValue(_getDuration(value.round()));
        },
        onChangeEnd: (double value) {
          widget.onChangeEnd?.call(_getDuration(value.round()));
        },
      ),
    );
  }

  Duration _getDuration(int value) {
    var hours = value ~/ 60;
    var minutes = value - (hours * 60);
    return Duration(hours: hours, minutes: minutes);
  }
}
