import 'package:equatable/equatable.dart';
import 'package:health_management/app/app.dart';

class EditProfileState<T> extends Equatable {
  final BlocStatus status;
  final T? data;
  final String? errorMessage;

  const EditProfileState._(
      {required this.status, this.data, this.errorMessage});

  factory EditProfileState.initial() {
    return EditProfileState._(status: BlocStatus.initial);
  }

  factory EditProfileState.loaded() {
    return EditProfileState._(status: BlocStatus.loaded);
  }

  factory EditProfileState.loading() {
    return EditProfileState._(status: BlocStatus.loading);
  }

  factory EditProfileState.success(T data) {
    return EditProfileState._(status: BlocStatus.success, data: data);
  }

  factory EditProfileState.error(String errorMessage) {
    return EditProfileState._(
        status: BlocStatus.error, errorMessage: errorMessage);
  }

  EditProfileState<T> copyWith({
    BlocStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return EditProfileState._(
        status: status ?? this.status,
        data: data ?? this.data,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, data, errorMessage];
}
