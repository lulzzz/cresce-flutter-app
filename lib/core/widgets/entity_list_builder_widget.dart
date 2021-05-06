import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/ui_bits/components/components.dart';
import 'package:flutter/widgets.dart';

class EntityListBuilder<T extends Deserialize> extends StatelessWidget {
  final Widget Function(BuildContext, List<T>) builder;

  const EntityListBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateBuilder<LoaderState<List<T>>>(
      builder: (context, state) {
        if (state is LoadingState) {
          return BitLoading();
        }
        if (state is LoadedResult<List<T>>) {
          return builder(context, state.data);
        }
        return Container();
      },
    );
  }
}
