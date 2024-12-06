import 'package:equatable/equatable.dart';
import 'package:health_management/app/app.dart';

class HomeState<T> extends Equatable {
  final BlocStatus status;
  final T? data;
  final String? errorMessage;

  const HomeState._({required this.status, this.data, this.errorMessage});

  factory HomeState.initial() {
    return HomeState._(status: BlocStatus.initial);
  }

  factory HomeState.loading() {
    return HomeState._(status: BlocStatus.loading);
  }

  factory HomeState.success(T data) {
    return HomeState._(status: BlocStatus.success, data: data);
  }

  factory HomeState.error(String errorMessage) {
    return HomeState._(status: BlocStatus.error, errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
