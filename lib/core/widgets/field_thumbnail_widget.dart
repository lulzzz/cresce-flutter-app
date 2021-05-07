import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/widgets.dart';

class FieldThumbnail extends StatelessWidget {
  const FieldThumbnail({
    Key key,
    @required this.entityField,
    @required this.onTap,
  }) : super(key: key);

  final Field entityField;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return entityField.buildValue(
      (entity) => BitThumbnail(
        onTap: onTap,
        width: 200,
        data: entity.toThumbnailData(),
      ),
    );
  }
}
