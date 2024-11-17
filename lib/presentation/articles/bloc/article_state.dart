import 'package:equatable/equatable.dart';
import 'package:health_management/app/app.dart';

class ArticleState<T> extends Equatable {
  final BlocStatus status;
  final T? data;
  final String? errorMessage;

  const ArticleState._({required this.status, this.data, this.errorMessage});

  factory ArticleState.initial() {
    return ArticleState._(status: BlocStatus.initial);
  }

  factory ArticleState.loading() {
    return ArticleState._(status: BlocStatus.loading);
  }

  factory ArticleState.success(T data) {
    return ArticleState._(status: BlocStatus.success, data: data);
  }

  factory ArticleState.error(String errorMessage) {
    return ArticleState._(status: BlocStatus.error, errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
