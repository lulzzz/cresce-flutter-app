import 'package:cresce_flutter_app/core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

abstract class ThumbnailDataFactory extends Deserialize {
  ThumbnailData toThumbnailData();
}

class EntityCarouselWidget<TEntity extends ThumbnailDataFactory>
    extends StatelessWidget {
  final void Function(TEntity employee) onSelect;

  EntityCarouselWidget({this.onSelect});

  @override
  Widget build(BuildContext context) {
    return BitFutureDataBuilder<List<TEntity>>(
      future: context.get<EntityListGateway<TEntity>>().getList(),
      onData: (data) => _makeCarousel(data),
    );
  }

  Widget _makeCarousel(List<TEntity> entities) {
    return BitCarousel(
      children: entities.map((entity) {
        return BitThumbnail(
          onTap: () => onSelect?.call(entity),
          width: 200,
          data: entity.toThumbnailData(),
        );
      }).toList(),
    );
  }
}

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
    //entityField.whenHasValue(
    //  (entity) => BitThumbnail(
    //    onTap: onTap,
    //    width: 200,
    //    data: entity.toThumbnailData(),
    //  ),
    //);
    return BitObservable(
      field: entityField,
      hasValue: (entity) => BitThumbnail(
        onTap: onTap,
        width: 200,
        data: entity.toThumbnailData(),
      ),
    );
  }
}
