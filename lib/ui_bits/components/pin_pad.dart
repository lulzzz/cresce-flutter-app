import '../ui_bits_internal.dart';

class BitPinPad extends StatelessWidget {
  final void Function(String) onTap;
  final void Function() onTapBack;
  final void Function() onTapClear;
  final Field<String> pinField;
  final BitAnimation animation;

  const BitPinPad({
    Key key,
    this.onTap = _defaultTap,
    this.pinField,
    this.animation = const BitNoAnimation(),
    this.onTapBack,
    this.onTapClear,
  }) : super(key: key);

  static void _defaultTap(String _) {}

  @override
  Widget build(BuildContext context) {
    return animation.wrapWidget(
      child: Column(
        children: _makeRows(context, this.pinField ?? Field.asText()),
      ),
    );
  }

  List<Widget> _makeRows(BuildContext context, Field<String> field) {
    return List.generate(3, (index) => index).map((index) {
      return Column(
        children: [
          _makeRow(
              context,
              [
                (3 * index + 1).toString(),
                (3 * index + 2).toString(),
                (3 * index + 3).toString(),
              ],
              field),
          SizedBox(height: context.sizes.mediumSmall),
        ],
      );
    }).toList()
      ..add(
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BitCircleButton(
                  iconData: FontAwesomeIcons.chevronLeft,
                  onTap: () {
                    onTap.call('back');
                    onTapBack?.call();
                  },
                ),
                SizedBox(width: context.sizes.medium),
                BitCircleButton(
                  label: '0',
                  onTap: () {
                    field.setValue(field.getValue() + '0');
                    onTap.call('0');
                  },
                ),
                SizedBox(width: context.sizes.medium),
                BitCircleButton(
                  iconData: FontAwesomeIcons.trash,
                  onTap: () {
                    field.setValue('');
                    onTap.call('clean');
                    onTapBack?.call();
                  },
                ),
              ],
            ),
            SizedBox(height: context.sizes.mediumSmall),
          ],
        ),
      );
  }

  Row _makeRow(BuildContext context, List<String> labels, Field<String> field) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BitCircleButton(
          label: labels[0],
          onTap: () => _handleTap(field, labels[0]),
        ),
        SizedBox(width: context.sizes.medium),
        BitCircleButton(
          label: labels[1],
          onTap: () => _handleTap(field, labels[1]),
        ),
        SizedBox(width: context.sizes.medium),
        BitCircleButton(
          label: labels[2],
          onTap: () => _handleTap(field, labels[2]),
        ),
      ],
    );
  }

  void _handleTap(Field<String> field, String label) {
    field.setValue(field.getValue() + label);
    onTap.call(label);
  }
}
