import 'package:cresce_flutter_app/features/authentication/authentication.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';

typedef OnLoginSuccessful(LoginResultDto result);
typedef OnLoginFailure();

class LoginServices {
  final HttpPost httpPost;

  const LoginServices(this.httpPost);

  void login(
    CredentialsDto credentials, {
    OnLoginSuccessful successCallback,
    OnLoginFailure failureCallback,
  }) {
    httpPost.post('api/v1/authentication/', credentials).then((value) {
      if (value.wasSuccess()) {
        successCallback?.call(
          value.deserialize<LoginResultDto>(LoginResultDto()),
        );
      } else {
        failureCallback?.call();
      }
    });
  }
}
