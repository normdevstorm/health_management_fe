import 'package:equatable/equatable.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

final class GetAllDoctorEvent extends HomeEvent {
  const GetAllDoctorEvent();
  @override
  List<Object?> get props => [];
}

final class GetAllDoctorTopRateEvent extends HomeEvent {
  const GetAllDoctorTopRateEvent();

  @override
  List<Object?> get props => [];
}
