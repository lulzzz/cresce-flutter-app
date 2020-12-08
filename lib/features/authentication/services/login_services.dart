import 'package:cresce_flutter_app/features/authentication/authentication.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';

typedef OnLoginSuccessful(Token result);
typedef OnLoginFailure();

class LoginServices {
  final HttpPost httpPost;

  const LoginServices(this.httpPost);

  void login(
    Credentials credentials, {
    OnLoginSuccessful successCallback,
    OnLoginFailure failureCallback,
  }) {
    httpPost.post('api/v1/authentication/', credentials).then((value) {
      if (value.wasSuccess()) {
        successCallback.call(value.deserialize<Token>(Token()));
      } else {
        failureCallback.call();
      }
    });
  }
}
