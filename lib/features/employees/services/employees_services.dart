import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:equatable/equatable.dart';
import 'package:ui_bits/ui_bits.dart';

class EmployeeServices {
  HttpGet httpGet;
  HttpPost httpPost;

  EmployeeServices(
    this.httpGet,
    this.httpPost,
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
        onSuccess(token);
      },
      onFailure: onFailure,
      deserialize: Token(),
    );
  }

  String _makePath(Organization organizationDto) =>
      'api/v1/organization/${organizationDto.name}/employees/';
}

class EmployeePin extends Equatable implements Serializable {
  final String employeeId;
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
  final String name;
  final String title;
  final BitImage image;

  Employee({
    this.name,
    this.title,
    this.image,
  });

  @override
  List<Object> get props => [name, title];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'image': image.toBase64(),
    };
  }

  Object fromMap(Map<String, dynamic> map) {
    return Employee(
      name: map['name'],
      title: map['title'],
      image: BitImageBase64(map['image']),
    );
  }

  @override
  Object deserialize(Map<String, dynamic> data) {
    return fromMap(data);
  }
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
