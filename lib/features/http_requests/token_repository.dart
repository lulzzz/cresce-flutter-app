import 'package:cresce_flutter_app/features/features.dart';

class TokenRepository {
  Token _token;

  void store(Token token) => _token = token;

  Token getToken() => _token;
}
