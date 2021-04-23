import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/widgets.dart';

class WeekDaysWidget extends StatelessWidget {
  final Field<List<WeekDay>> field;
  final List<Field<bool>> weekdayFields = [
    Field.as<bool>(),
    Field.as<bool>(),
    Field.as<bool>(),
    Field.as<bool>(),
    Field.as<bool>(),
    Field.as<bool>(),
    Field.as<bool>(),
  ];

  WeekDaysWidget({
    Key key,
    this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    weekdayFields.forEach((element) {
      element.onChange((data) {
        if (weekdayFields == null || weekdayFields.isEmpty) return;

        field?.setValue([
          weekdayFields[0].getValue() != null ? WeekDay.monday : null,
          weekdayFields[1].getValue() != null ? WeekDay.tuesday : null,
          weekdayFields[2].getValue() != null ? WeekDay.wednesday : null,
          weekdayFields[3].getValue() != null ? WeekDay.thursday : null,
          weekdayFields[4].getValue() != null ? WeekDay.friday : null,
          weekdayFields[5].getValue() != null ? WeekDay.saturday : null,
          weekdayFields[6].getValue() != null ? WeekDay.sunday : null,
        ].where((element) => element != null).toList());
      });
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: Iterable<int>.generate(7)
          .map(
            (e) => BitCheckBox(
              field: weekdayFields[e],
              orientation: const BitTopOrientation(),
              label: context.formatWeekday(_calculateWeekday(e)),
            ),
          )
          .toList(),
    );
  }

  DateTime _calculateWeekday(int e) => DateTime(2021, 1, 4 + e);
}
