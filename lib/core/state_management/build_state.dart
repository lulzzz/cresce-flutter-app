import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';

typedef StateBuildFunction<S> = Widget Function(BuildContext context, S state);

abstract class IBuildState<S> {
  Widget build(StateBuildFunction<S> builder);
}

abstract class IFetchData<T> {
  void load();
}
