import 'package:cresce_flutter_app/features/authentication/authentication.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';

typedef OnLoginSuccessful(Token result);
typedef OnLoginFailure();

class LoginServices {
  final HttpPost httpPost;

  const LoginServices(this.httpPost);

  void login(
    Credentials credentials, {
    OnLoginSuccessful onSuccess,
    OnLoginFailure onFailure,
  }) {
    httpPost.post('api/v1/authentication/', credentials).then((value) {
      if (value.wasSuccess()) {
        onSuccess.call(value.deserialize<Token>(Token()));
      } else {
        onFailure.call();
      }
    });
  }
}
