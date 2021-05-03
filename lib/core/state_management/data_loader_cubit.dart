import 'package:cresce_flutter_app/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataLoaderCubit<T extends Deserialize>
    extends Cubit<LoaderState<List<T>>> {
  final EntityListGateway<T> gateway;

  DataLoaderCubit(this.gateway) : super(LoadedResult<List<T>>());

  void load() async {
    try {
      emit(LoadingState<List<T>>());
      var data = await gateway.getList();
      emit(LoadedResult<List<T>>(data: data));
    } on Exception catch (e) {
      emit(LoadingFailState<List<T>>(e));
    }
  }
}

class LoaderState<T> {}

class LoadingState<T> implements LoaderState<T> {}

class LoadingFailState<T> implements LoaderState<T> {
  final Exception exception;

  LoadingFailState(this.exception);
}

class LoadedResult<T> extends Equatable implements LoaderState<T> {
  final T data;

  LoadedResult({this.data});

  @override
  List<Object> get props => [data];
}
