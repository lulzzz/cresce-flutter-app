import 'package:cresce_flutter_app/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  EquatableConfig.stringify = true;

  group('invalid data', () {
    test('fromMap returns service instance (value: 10)', () {
      var data = {
        'value': 10,
        'name': 'test',
        'id': 1,
      };

      var service = Service().fromMap(data);

      expect(service, Service(value: 10, name: 'test', id: 1));
    });
    test('fromMap returns service instance (value: x)', () {
      var data = {
        'value': 'x',
        'name': 'test',
        'id': 1,
      };

      var service = Service().fromMap(data);

      expect(service, Service(value: 0, name: 'test', id: 1));
    });
    test('fromMap returns service instance (value: empty)', () {
      var data = {
        'value': '',
        'name': 'test',
        'id': 1,
      };

      var service = Service().fromMap(data);

      expect(service, Service(value: 0, name: 'test', id: 1));
    });
    test('fromMap returns service instance (value: null)', () {
      var data = {
        'value': null,
        'name': 'test',
        'id': 1,
      };

      var service = Service().fromMap(data);

      expect(service, Service(value: 0, name: 'test', id: 1));
    });
  });
}
