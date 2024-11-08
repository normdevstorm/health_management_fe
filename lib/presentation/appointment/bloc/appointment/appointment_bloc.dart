import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/domain/appointment/usecases/appointment_usecase.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/domain/health_provider/entities/health_provider_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
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
    on<CreateAppointmentRecordChooseHealthProviderEvent>((event, emit) =>
        _onCreateAppointmentRecordChooseHealthProviderEvent(event, emit));
    on<CreateAppointmentRecordChooseDoctorEvent>((event, emit) =>
        _onCreateAppointmentRecordChooseDoctorEvent(event, emit));
    on<CreateAppointmentRecordChooseDatetimeEvent>((event, emit) =>
        _onCreateAppointmentRecordChooseDatetimeEvent(event, emit));
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
    AppointmentRecordEntity filledAppointmentRecordEntity =
        state.data as AppointmentRecordEntity;
    emit(CreateAppointmentRecordState.loading());
    try {
      final appointmentRecord = await appointmentUseCase
          .createAppointmentRecord(filledAppointmentRecordEntity);
      emit(CreateAppointmentRecordState.success(
          createdAppointmentRecordEntity: appointmentRecord));
    } catch (e) {
      emit(CreateAppointmentRecordState.error(e.toString()));
    }
  }

  _onCreateAppointmentRecordChooseHealthProviderEvent(
      CreateAppointmentRecordChooseHealthProviderEvent event,
      Emitter<AppointmentState> emit) {
    emit(CreateAppointmentRecordState.initial());
    final int? providerId = event.appointmentRecordEntity.healthProvider?.id;
    emit(CreateAppointmentRecordState.inProgress(
        createAppointmentRecordEntity: (state.data as AppointmentRecordEntity)
            .copyWith(
                user: UserEntity(id: 3),
                healthProvider: HealthProviderEntity(id: providerId),
                appointmentType: AppointmentType.inPerson)));
  }

  _onCreateAppointmentRecordChooseDoctorEvent(
      CreateAppointmentRecordChooseDoctorEvent event,
      Emitter<AppointmentState> emit) {
    final int doctorId = event.doctorId;
    emit(CreateAppointmentRecordState.inProgress(
        createAppointmentRecordEntity: (state.data as AppointmentRecordEntity)
            .copyWith(
                doctor:
                    UserEntity(doctorProfile: DoctorEntity(id: doctorId)))));
  }

  _onCreateAppointmentRecordChooseDatetimeEvent(
      CreateAppointmentRecordChooseDatetimeEvent event,
      Emitter<AppointmentState> emit) {
    final DateTime scheduledAt = event.scheduledAt;
    emit(CreateAppointmentRecordState.inProgress(
        createAppointmentRecordEntity: (state.data as AppointmentRecordEntity)
            .copyWith(
                scheduledAt: scheduledAt,
                status: AppointmentStatus.scheduled,
                note: "This one is created manually")));
  }
}
