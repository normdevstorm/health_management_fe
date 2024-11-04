import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/domain/appointment/usecases/appointment_usecase.dart';
part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentUseCase appointmentUseCase;

  AppointmentBloc({required this.appointmentUseCase})
      : super(AppointmentState.initial()) {
    on<GetAllAppointmentRecordEvent>(
        (event, emit) => _onGetAllAppointmentRecordEvent(event, emit));
    on<GetAppointmentDetailEvent>(
        (event, emit) => _onGetAppointmentDetailEvent(event, emit));
    on<CreateAppointmentRecordEvent>(
        (event, emit) => _onCreateAppointmentRecordEvent(event, emit));
    on<UpdateAppointmentRecordEvent>(
        (event, emit) => _onUpdateAppointmentRecordEvent(event, emit));
    on<DeleteAppointmentRecordEvent>(
        (event, emit) => _onDeleteAppointmentRecordEvent(event, emit));
  }

  _onGetAllAppointmentRecordEvent(GetAllAppointmentRecordEvent event,
      Emitter<AppointmentState> emit) async {
    emit(AppointmentState.loading());
    try {
      final appointmentRecords =
          await appointmentUseCase.getAllAppointmentRecords();
      emit(AppointmentState.success(appointmentRecords));
    } catch (e) {
      emit(AppointmentState.error(e.toString()));
    }
  }

  _onGetAppointmentDetailEvent(
      GetAppointmentDetailEvent event, Emitter<AppointmentState> emit) async {
    // emit(AppointmentState.loading());
    // try {
    //   final appointmentRecord = await appointmentUseCase.getAppointmentRecord(event.appointmentId);
    //   emit(AppointmentState.success(appointmentRecord));
    // } catch (e) {
    //   emit(AppointmentState.error(e.toString()));
    // }
  }

  _onUpdateAppointmentRecordEvent(UpdateAppointmentRecordEvent event,
      Emitter<AppointmentState> emit) async {
    emit(AppointmentState.loading());
    try {
      final appointmentRecord = await appointmentUseCase
          .updateAppointmentRecord(event.updateAppointmentRecordEntity);
      emit(AppointmentState.success(appointmentRecord));
    } catch (e) {
      emit(AppointmentState.error(e.toString()));
    }
  }

  _onDeleteAppointmentRecordEvent(DeleteAppointmentRecordEvent event,
      Emitter<AppointmentState> emit) async {
    emit(AppointmentState.loading());
    try {
      final appointmentId =
          await appointmentUseCase.deleteAppointmentRecord(event.appointmentId);
      emit(AppointmentState.success(appointmentId));
    } catch (e) {
      emit(AppointmentState.error(e.toString()));
    }
  }

  _onCreateAppointmentRecordEvent(CreateAppointmentRecordEvent event,
      Emitter<AppointmentState> emit) async {
    emit(AppointmentState.loading());
    try {
      final appointmentRecord = await appointmentUseCase
          .createAppointmentRecord(event.appointmentRecordEntity);
      emit(AppointmentState.success(appointmentRecord));
    } catch (e) {
      emit(AppointmentState.error(e.toString()));
    }
  }
}
