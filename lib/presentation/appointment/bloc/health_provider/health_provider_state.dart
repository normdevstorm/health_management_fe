part of 'health_provider_bloc.dart';

class HealthProviderState<T> extends Equatable {
  final BlocStatus status;
  final T? data;
  final String? errorMessage;

  const HealthProviderState._({required this.status, this.data, this.errorMessage});
 
  factory HealthProviderState.initial() {
    return HealthProviderState._(status: BlocStatus.initial);
  }

  factory HealthProviderState.loading() {
    return HealthProviderState._(status: BlocStatus.loading);
  }

  factory HealthProviderState.success(T data) {
    return HealthProviderState._(status: BlocStatus.success, data: data);
  }

  factory HealthProviderState.error(String errorMessage) {
    return HealthProviderState._(status: BlocStatus.error, errorMessage: errorMessage);
  }

  HealthProviderState<T> copyWith({
    BlocStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return HealthProviderState._(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
