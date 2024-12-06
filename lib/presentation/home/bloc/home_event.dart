import 'package:equatable/equatable.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';

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
