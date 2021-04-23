import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';

class TestModel implements Serializable, Deserialize, ThumbnailDataFactory {
  @override
  String serialize(Encoder encoder) {
    return encoder.encode({
      'test': 'data',
    });
  }

  @override
  Object deserialize(Object data) {
    return this;
  }

  @override
  ThumbnailData toThumbnailData() {
    return ThumbnailData(
      title: 'test',
    );
  }
}
