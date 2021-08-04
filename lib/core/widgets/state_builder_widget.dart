import 'package:cresce_flutter_app/core/core.dart';
import 'package:flutter/widgets.dart';

class StateBuilder<S> extends StatelessWidget {
  final StateBuildFunction<S> builder;

  const StateBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      context.get<IBuildState<S>>().build(builder);
}
