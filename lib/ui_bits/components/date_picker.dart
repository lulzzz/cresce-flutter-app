import 'package:intl/intl.dart';

import '../ui_bits_internal.dart';

class BitDatePicker extends StatelessWidget {
  final Field<DateTime> field;
  final Field<String> dateText = Field.asText(
    initialValue: DateFormat.yMd().format(DateTime.now()),
  );

  BitDatePicker({
    this.field,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var datetime = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1970),
          lastDate: DateTime(DateTime.now().year + 10),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context), // This will change to light theme.
              child: child,
            );
          },
        );

        field?.setValue(datetime);
        dateText.setValue(DateFormat.yMd().format(datetime));
      },
      child: BitInputTextField(
        FieldLabels(
          label: 'Pick a date',
          icon: FontAwesomeIcons.calendar,
        ),
        field: dateText,
        enabled: false,
      ),
    );
  }
}
