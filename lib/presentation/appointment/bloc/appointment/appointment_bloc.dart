import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/config/api_exception.dart';
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
    on<CollectDataHealthProviderEvent>(
        (event, emit) => _onCollectDataHealthProviderEvent(event, emit));
    on<ColectDataDoctorEvent>(
        (event, emit) => _onColectDataDoctorEvent(event, emit));
    on<CollectDataDatetimeAndNoteEvent>(
        (event, emit) => _onCollectDataDatetimeEvent(event, emit));
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
          await appointmentUseCase.getAppointmentRecordByUserId(userId: 1);
      emit(AppointmentState.success(appointmentRecords));
    } on ApiException catch (e) {
      emit(AppointmentState.error(ApiException.getErrorMessage(e)));
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
    } on ApiException catch (e) {
      emit(AppointmentState.error(ApiException.getErrorMessage(e)));
    }
  }

  _onDeleteAppointmentRecordEvent(DeleteAppointmentRecordEvent event,
      Emitter<AppointmentState> emit) async {
    emit(CancelAppointmentRecordState.loading());
    try {
      final String message =
          await appointmentUseCase.deleteAppointmentRecord(event.appointmentId);
      emit(CancelAppointmentRecordState.success(message));
    } on ApiException catch (e) {
      emit(CancelAppointmentRecordState.error(ApiException.getErrorMessage(e)));
    }
  }

  _onCreateAppointmentRecordEvent(CreateAppointmentRecordEvent event,
      Emitter<AppointmentState> emit) async {
    AppointmentRecordEntity filledAppointmentRecordEntity =
        state.data as AppointmentRecordEntity;
    emit(CreateAppointmentRecordState.loading(
        createAppointmentRecordEntity: filledAppointmentRecordEntity));
    try {
      final appointmentRecord = await appointmentUseCase
          .createAppointmentRecord(filledAppointmentRecordEntity);
      emit(CreateAppointmentRecordState.success(
          createdAppointmentRecordEntity: appointmentRecord));
    } on ApiException catch (e) {
      emit(CreateAppointmentRecordState.error(ApiException.getErrorMessage(e),
          createdAppointmentRecordEntity: filledAppointmentRecordEntity));
    }
  }

  _onCollectDataHealthProviderEvent(
      CollectDataHealthProviderEvent event, Emitter<AppointmentState> emit) {
    emit(CreateAppointmentRecordState.initial());
    final int? providerId = event.appointmentRecordEntity.healthProvider?.id;
    emit(CreateAppointmentRecordState.inProgress(
        createAppointmentRecordEntity: (state.data as AppointmentRecordEntity)
            .copyWith(
                user: UserEntity(id: 1),
                healthProvider: HealthProviderEntity(id: providerId),
                appointmentType: AppointmentType.inPerson)));
  }

  _onColectDataDoctorEvent(
      ColectDataDoctorEvent event, Emitter<AppointmentState> emit) {
    final int doctorId = event.doctorId;
    emit(CreateAppointmentRecordState.inProgress(
        createAppointmentRecordEntity: (state.data as AppointmentRecordEntity)
            .copyWith(
                doctor:
                    UserEntity(doctorProfile: DoctorEntity(id: doctorId)))));
  }

  _onCollectDataDatetimeEvent(
      CollectDataDatetimeAndNoteEvent event, Emitter<AppointmentState> emit) {
    final DateTime scheduledAt = event.scheduledAt;
    final String? note = event.note;
    emit(CreateAppointmentRecordState.inProgress(
        createAppointmentRecordEntity: (state.data as AppointmentRecordEntity)
            .copyWith(
                scheduledAt: scheduledAt,
                status: AppointmentStatus.scheduled,
                note: note)));
  }
}
