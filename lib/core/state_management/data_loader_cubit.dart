import 'package:cresce_flutter_app/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataLoaderCubit<T extends Deserialize> extends Cubit<LoaderState<List<T>>>
    implements IFetchData<List<T>> {
  final EntityListGateway<T> gateway;

  DataLoaderCubit(this.gateway) : super(LoaderState<List<T>>()) {
    load();
  }

  void load() {
    emit(LoadingState<List<T>>());

    gateway
        .getList()
        .then((value) => emit(LoadedResult<List<T>>(data: value)))
        .onError((error, _) => emit(LoadingFailState<List<T>>(error)));
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
