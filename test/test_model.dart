import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';

class TestModel implements Serializable, Deserialize, ThumbnailDataFactory {
  @override
  String serialize(Encoder encoder) => encoder.encode({
        'test': 'data',
      });

  @override
  Object deserialize(Object data) => this;

  @override
  ThumbnailData toThumbnailData() => ThumbnailData(
        title: 'test',
      );
}
