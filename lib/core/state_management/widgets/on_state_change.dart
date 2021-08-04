import 'package:cresce_flutter_app/core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WidgetFactory<TState> {
  Widget build(BuildContext context, TState state);

  bool canHandleState(TState state);
}

class OnStateChange<TState> extends StatelessWidget {
  final WidgetFactory<TState> _widgetFactory;

  OnStateChange(this._widgetFactory);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.get<BlocBase<TState>>(),
      builder: (context, state) {
        if (_widgetFactory.canHandleState(state)) {
          return _widgetFactory.build(context, state);
        }
        return Container();
      },
    );
  }
}
