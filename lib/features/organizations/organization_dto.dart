import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:equatable/equatable.dart';

class OrganizationDto extends Equatable implements Deserialize {
  final String name;

  OrganizationDto({
    this.name,
  });

  @override
  List<Object> get props => [name];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  Object fromMap(Map<String, dynamic> map) {
    return OrganizationDto(
      name: map['name'],
    );
  }

  @override
  Object deserialize(Map<String, dynamic> map) {
    return fromMap(map);
  }
}

class OrganizationListDto implements Serializable, Deserialize {
  List<OrganizationDto> list;

  OrganizationListDto([this.list]);

  @override
  String serialize(Encoder encoder) {
    return encoder.encodeList(
      list.map((obj) => obj.toMap()).toList(),
    );
  }

  @override
  Object deserialize(dynamic data) {
    var list = data as List;
    return list.map((item) => OrganizationDto().fromMap(item)).toList();
  }
}
