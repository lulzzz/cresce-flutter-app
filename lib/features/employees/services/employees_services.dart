import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:equatable/equatable.dart';

class EmployeeServices implements EntityListGateway<Employee> {
  final HttpGet _httpGet;
  final HttpPost _httpPost;
  final TokenRepository _tokenRepository;

  EmployeeServices(
    this._httpGet,
    this._httpPost,
    this._tokenRepository,
  );

  Future<List<Employee>> getList() {
    return _httpGet.getList<Employee>(
      url: 'api/v1/organization/myOrganization/employees/',
      deserialize: Employee(),
    );
  }

  void login(
    EmployeePin employeePin, {
    void Function(Token result) onSuccess,
    void Function() onFailure,
  }) {
    _httpPost.postElement(
      url: 'api/v1/employees/',
      body: employeePin,
      onSuccess: (token) {
        _tokenRepository.store(token);
        onSuccess?.call(token);
      },
      onFailure: onFailure,
      deserialize: Token(),
    );
  }

  void logout() {
    _tokenRepository.removeLastToken();
  }
}

class EmployeePin extends Equatable implements Serializable {
  final int employeeId;
  final String pin;

  EmployeePin({this.employeeId, this.pin});

  @override
  String serialize(Encoder encoder) {
    return encoder.encode(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'pin': pin,
    };
  }

  @override
  List<Object> get props => toMap().values.toList();
}

class Employee extends Equatable implements Deserialize, ThumbnailDataFactory {
  final int id;
  final String name;
  final String title;
  final BitImage image;

  Employee({
    this.id,
    this.name,
    this.title,
    this.image,
  });

  @override
  List<Object> get props => [id, name, title];

  ThumbnailData toThumbnailData() {
    return ThumbnailData(
      title: name,
      subTitle: title,
      image: Future.value(image),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'image': image?.toBase64(),
    };
  }

  Object fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      title: map['title'],
      image: BitImageBase64(map['image']),
    );
  }

  @override
  Object deserialize(Map<String, dynamic> data) => fromMap(data);
}

class EmployeeList implements Serializable, Deserialize {
  List<Employee> list;

  EmployeeList([this.list]);

  @override
  String serialize(Encoder encoder) {
    return encoder.encodeList(
      list.map((obj) => obj.toMap()).toList(),
    );
  }

  @override
  Object deserialize(dynamic data) {
    var list = data as List;
    return list.map((item) => Employee().fromMap(item)).toList();
  }
}
