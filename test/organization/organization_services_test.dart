import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../monitor.dart';


main() {
  EquatableConfig.stringify = true;
  Monitor monitor;
  List<OrganizationDto> result;

  setUp(() {
    monitor = Monitor();
  });

  void onSuccessHandler(List<OrganizationDto> orgs) {
    result = orgs;
    monitor.signal();
  }

  test('on successful login calls given callback function', () async {
    final services = makeServices();

    services.getUserOrganizations(
      'myUser',
      onSuccess: onSuccessHandler,
    );

    await monitor.wait();

    print(
      OrganizationListDto(result).serialize(JsonFormatter()),
    );
  });
}

OrganizationServices makeServices() => OrganizationServices(makeHttpGet());

class OrganizationServices {
  HttpGet httpGet;

  OrganizationServices(this.httpGet);

  void getUserOrganizations(
    String userId, {
    void Function(List<OrganizationDto>) onSuccess,
  }) {
    httpGet.get('api/v1/$userId/organization').then((value) {
      onSuccess(value.deserializeList(OrganizationDto()));
    });
  }
}

class HttpGetMock extends Mock implements HttpGet {}

HttpGet makeHttpGet() {
  var httpGet = HttpGetMock();
  var formatter = JsonFormatter();

  when(httpGet.get('api/v1/unknown_user/organization')).thenAnswer((_) {
    return Future.value(HttpResponse(
      formatter,
      statusCode: 400,
    ));
  });

  when(httpGet.get('api/v1/myUser/organization')).thenAnswer((_) {
    return Future.value(HttpResponse(
      formatter,
      statusCode: 200,
      content: OrganizationListDto([
        OrganizationDto(name: 'myOrg'),
      ]).serialize(formatter),
    ));
  });

  return httpGet;
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
