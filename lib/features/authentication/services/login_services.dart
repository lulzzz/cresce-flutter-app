import 'package:cresce_flutter_app/features/authentication/authentication.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';

typedef OnLoginSuccessful(Token result);
typedef OnLoginFailure();

class LoginServices {
  final HttpPost httpPost;
  final TokenRepository _tokenRepository;

  const LoginServices(this.httpPost, this._tokenRepository);

  void login(
    Credentials credentials, {
    OnLoginSuccessful onSuccess,
    OnLoginFailure onFailure,
  }) {
    httpPost.post('api/v1/authentication/', credentials).then((value) {
      if (value.wasSuccess()) {
        var token = value.deserialize<Token>(Token());
        _tokenRepository.store(token);
        onSuccess.call(token);
      } else {
        onFailure.call();
      }
    });
  }
}
