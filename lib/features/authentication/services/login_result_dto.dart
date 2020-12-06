import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:equatable/equatable.dart';

class LoginResultDto extends Equatable implements Serializable, Deserialize {
  final String organizationUrl;
  final String token;

  LoginResultDto({
    this.organizationUrl,
    this.token,
  });

  @override
  String serialize(Encoder encoder) {
    return encoder.encode(toMap());
  }

  @override
  Object deserialize(Map<String, dynamic> data) {
    return fromMap(data);
  }

  Object fromMap(Map<String, Object> map) {
    return LoginResultDto(
      organizationUrl: map['organizationUrl'],
      token: map['token'],
    );
  }

  Map<String, Object> toMap() {
    return {
      'organizationUrl': organizationUrl,
      'token': token,
    };
  }

  @override
  List<Object> get props => [organizationUrl, token];
}
