import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';
import 'package:equatable/equatable.dart';
import 'package:ui_bits/ui_bits.dart';

class CustomerServices {
  final HttpGet httpGet;

  CustomerServices(
    this.httpGet,
  );

  Future<List<Customer>> getCustomers() {
    return httpGet.getList<Customer>(
      url: 'api/v1/customers/',
      deserialize: Customer(),
    );
  }
}

class Customer extends Equatable implements Deserialize {
  final int id;
  final String name;
  final BitImage image;

  Customer({
    this.id,
    this.name,
    this.image,
  });

  @override
  List<Object> get props => [id, name];

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
      'image': image?.toBase64(),
    };
  }

  Object fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      image: BitImageBase64(map['image']),
    );
  }

  @override
  Object deserialize(Map<String, dynamic> data) => fromMap(data);
}

class CustomerList implements Serializable, Deserialize {
  List<Customer> list;

  CustomerList([this.list]);

  @override
  String serialize(Encoder encoder) {
    return encoder.encodeList(
      list.map((obj) => obj.toMap()).toList(),
    );
  }

  @override
  Object deserialize(dynamic data) {
    var list = data as List;
    return list.map((item) => Customer().fromMap(item)).toList();
  }
}
