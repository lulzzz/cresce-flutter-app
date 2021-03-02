import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

abstract class ThumbnailDataFactory {
  ThumbnailData toThumbnailData();
}

class EntityCarouselWidget<TEntity extends ThumbnailDataFactory>
    extends StatelessWidget {
  final void Function(TEntity employee) onSelect;
  final Future<List<TEntity>> Function(BuildContext) entitiesFuture;

  EntityCarouselWidget({
    this.onSelect,
    this.entitiesFuture,
  });

  @override
  Widget build(BuildContext context) {
    return BitFutureDataBuilder<List<TEntity>>(
      future: entitiesFuture(context),
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
