import 'package:equatable/equatable.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

final class GetAllDoctorEvent extends HomeEvent {
  const GetAllDoctorEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetAllDoctorTopRateEvent extends HomeEvent {
  const GetAllDoctorTopRateEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
