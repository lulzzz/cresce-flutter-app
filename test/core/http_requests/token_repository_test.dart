import 'package:cresce_flutter_app/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getting token before store returns null', () {
    var repository = TokenRepository();

    expect(repository.getToken(), isNull);
  });
}
