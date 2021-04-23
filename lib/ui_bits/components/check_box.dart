import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter/widgets.dart';

class BitCheckBox extends StatefulWidget {
  final Field<bool> field;
  final String label;
  final BitOrientation orientation;

  BitCheckBox({
    Key key,
    this.field,
    this.label = 'empty label',
    this.orientation = const BitLeftOrientation(),
  }) : super(key: key);

  @override
  _BitCheckBoxState createState() => _BitCheckBoxState();
}

class _BitCheckBoxState extends State<BitCheckBox> {
  final Field<bool> _valueField = Field.asBool();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _valueField.setValue(!_valueField.getValue());
      },
      child: widget.orientation.build(
        Text(widget.label),
        BitObservable<bool>(
          field: _valueField,
          builder: (value) => Checkbox(
            value: value,
            onChanged: (value) {
              widget.field?.setValue(value);
              _valueField.setValue(value);
            },
          ),
        ),
      ),
    );
  }
}
