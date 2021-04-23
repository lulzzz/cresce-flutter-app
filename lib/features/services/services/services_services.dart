import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:equatable/equatable.dart';

class ServiceServices implements EntityListGateway<Service> {
  final HttpGet _httpGet;

  ServiceServices(
    this._httpGet,
  );

  Future<List<Service>> getList() {
    return _httpGet.getList<Service>(
      url: 'api/v1/services/',
      deserialize: Service(),
    );
  }
}

class Service extends Equatable implements Deserialize, ThumbnailDataFactory {
  final int id;
  final String name;
  final double value;
  final BitImage image;

  Service({
    this.id,
    this.name,
    this.value,
    this.image,
  });

  @override
  List<Object> get props => [id, name, value];

  ThumbnailData toThumbnailData() {
    return ThumbnailData(
      title: name,
      image: Future.value(image),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'image': image?.toBase64(),
    };
  }

  Object fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'],
      name: map['name'],
      value: convertToDouble(map['value']),
      image: convertToImage(map['image'] as String),
    );
  }

  @override
  Object deserialize(Map<String, dynamic> data) => fromMap(data);
}

class ServiceList implements Serializable, Deserialize {
  List<Service> list;

  ServiceList([this.list]);

  @override
  String serialize(Encoder encoder) {
    return encoder.encodeList(
      list.map((obj) => obj.toMap()).toList(),
    );
  }

  @override
  Object deserialize(dynamic data) {
    var list = data as List;
    return list.map((item) => Service().fromMap(item)).toList();
  }
}
