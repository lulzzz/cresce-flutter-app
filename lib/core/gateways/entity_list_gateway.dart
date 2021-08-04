import 'package:cresce_flutter_app/core/core.dart';

abstract class EntityListGateway<T extends Deserialize> {
  Future<List<T>> getList();
}
