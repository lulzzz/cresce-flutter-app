import 'package:cresce_flutter_app/core/core.dart';

class TokenRepository {
  List<Token> _token = [];

  void store(Token token) => _token.add(token);

  Token getToken() => _token.last;

  void removeLastToken() => _token.removeLast();
}
