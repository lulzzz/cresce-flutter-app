import 'package:cresce_flutter_app/features/authentication/authentication.dart';
import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';

typedef void OnLoginSuccessful(Token result);
typedef void OnLoginFailure();

class LoginServices {
  final HttpPost _httpPost;
  final TokenRepository _tokenRepository;

  const LoginServices(this._httpPost, this._tokenRepository);

  void login(
    Credentials credentials, {
    OnLoginSuccessful onSuccess,
    OnLoginFailure onFailure,
  }) {
    _httpPost.postElement(
      url: 'api/v1/authentication/',
      body: credentials,
      onSuccess: (token) {
        _tokenRepository.store(token);
        onSuccess(token);
      },
      onFailure: onFailure,
      deserialize: Token(),
    );
  }
}
