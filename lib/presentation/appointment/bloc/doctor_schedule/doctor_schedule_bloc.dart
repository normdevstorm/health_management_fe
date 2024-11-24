import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/domain/doctor_schedule/entities/doctor_schedule_entity.dart';
import '../../../../domain/doctor_schedule/repositories/doctor_schedule_repository.dart';
part 'doctor_schedule_state.dart';
part 'doctor_schedule_event.dart';

class DoctorScheduleBloc extends Bloc<DoctorScheduleEvent, DoctorScheduleState> {
  final DoctorScheduleRepository _doctorScheduleRepository;

  DoctorScheduleBloc(this._doctorScheduleRepository) : super(DoctorScheduleState.initial()){
    
    on<GetDoctorScheduleEvent>((event, emit) => _onGetDoctorScheduleEvent(event, emit));
  }
  
  _onGetDoctorScheduleEvent(GetDoctorScheduleEvent event, Emitter<DoctorScheduleState> emit) async {
    emit(DoctorScheduleState.loading());
    try {
      final doctorSchedule = await _doctorScheduleRepository.getDoctorSchedule(event.doctorId);
      emit(DoctorScheduleState.success(doctorSchedule));
    } catch (e) {
      emit(DoctorScheduleState.error(e.toString()));
    }
  }

}