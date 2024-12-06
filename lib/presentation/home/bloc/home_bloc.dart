import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/domain/doctor/usecases/doctor_usecase.dart';
import 'package:health_management/presentation/home/bloc/home_event.dart';
import 'package:health_management/presentation/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DoctorUseCase doctorUseCase;

  HomeBloc({required this.doctorUseCase}) : super(HomeState.initial()) {
    on<GetAllDoctorTopRateEvent>(
        (event, emit) => _onGetAllDoctorTopRateEvent(event, emit));
  }

  _onGetAllDoctorTopRateEvent(HomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeState.loading());
    try {
      final doctor = await doctorUseCase.getAllDoctorTopRated();
      emit(HomeState.success(doctor));
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }
}
