import 'package:cresce_flutter_app/features/authentication/services/token.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:equatable/equatable.dart';

typedef OnFetchSuccessful(List<Employee> employees);
typedef OnFetchFailure();

class EmployeeServices {
  HttpGet httpGet;

  EmployeeServices(this.httpGet);

  void fetchEmployees(
    Organization organizationDto, {
    OnFetchSuccessful onSuccess,
    OnFetchFailure onFailure,
  }) {
    httpGet.get(_makePath(organizationDto)).then((value) {
      if (value.wasSuccess()) {
        onSuccess(value.deserializeList(Employee()));
      } else {
        onFailure();
      }
    });
  }

  String _makePath(Organization organizationDto) =>
      'api/v1/organization/${organizationDto.name}/employees';
}

class Employee extends Equatable implements Deserialize {
  final String name;

  Employee({this.name});

  @override
  List<Object> get props => [name];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  Object fromMap(Map<String, dynamic> map) {
    return Employee(
      name: map['name'],
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
