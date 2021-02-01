import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:equatable/equatable.dart';
import 'package:ui_bits/ui_bits.dart';

class EmployeeServices {
  final HttpGet httpGet;
  final HttpPost httpPost;
  final TokenRepository tokenRepository;

  EmployeeServices(
    this.httpGet,
    this.httpPost,
    this.tokenRepository,
  );

  Future<List<Employee>> getEmployees(Organization organizationDto) {
    return httpGet.getList<Employee>(
      url: _makePath(organizationDto),
      deserialize: Employee(),
    );
  }

  void login(
    EmployeePin employeePin, {
    void Function(Token result) onSuccess,
    void Function() onFailure,
  }) {
    httpPost.postElement(
      url: 'api/v1/employees/',
      body: employeePin,
      onSuccess: (token) {
        tokenRepository.store(token);
        onSuccess?.call(token);
      },
      onFailure: onFailure,
      deserialize: Token(),
    );
  }

  String _makePath(Organization organizationDto) =>
      'api/v1/organization/${organizationDto.name}/employees/';

  void logout() {
    tokenRepository.removeLastToken();
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
  List<Object> get props => [employeeId, pin];
}

class Employee extends Equatable implements Deserialize {
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
