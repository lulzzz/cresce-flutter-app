import 'package:cresce_flutter_app/core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoaderStateBuilder<T extends Deserialize>
    implements IBuildState<LoaderState<List<T>>> {
  @override
  Widget build(StateBuildFunction<LoaderState<List<T>>> builder) {
    return BlocBuilder<DataLoaderCubit<T>, LoaderState<List<T>>>(
      builder: builder,
    );
  }
}
