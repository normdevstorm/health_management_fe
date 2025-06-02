import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/domain/appointment/usecases/appointment_usecase.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/domain/health_provider/entities/health_provider_entity.dart';
import 'package:health_management/domain/health_provider/usecases/health_provider_usecase.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentUseCase appointmentUseCase;
  final HealthProviderUseCase healthProviderUseCase;

  AppointmentBloc(
      {required this.appointmentUseCase, required this.healthProviderUseCase})
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
    on<UpdatePrescriptionEvent>(
        (event, emit) => _onUpdatePrescriptionEvent(event, emit));
  }

  _onGetAllAppointmentRecordEvent(GetAllAppointmentRecordEvent event,
      Emitter<AppointmentState> emit) async {
    emit(AppointmentState.loading());
    try {
      final user = await SharedPreferenceManager.getUser();
      final List<AppointmentRecordEntity> appointmentRecords;
      if (user!.account!.role == Role.doctor) {
        appointmentRecords = await appointmentUseCase
            .getAppointmentRecordByDoctorId(doctorId: user.doctorProfile!.id!);
      } else {
        appointmentRecords = await appointmentUseCase
            .getAppointmentRecordByUserId(userId: user.id!);
      }
      emit(AppointmentState.success(appointmentRecords));
    } on ApiException catch (e) {
      emit(AppointmentState.error(ApiException.getErrorMessage(e)));
    }
  }

  _onGetAppointmentDetailEvent(
      GetAppointmentDetailEvent event, Emitter<AppointmentState> emit) async {
    emit(GetAppointmentDetailState.loading());
    try {
      final appointmentRecord = await appointmentUseCase
          .getAppointmentRecordById(appointmentId: event.appointmentId);
      final healthProviderList =
          await healthProviderUseCase.getAllHealthProvider();
      final healthProvider = healthProviderList.firstWhere(
          (element) => element.id == appointmentRecord.healthProvider?.id);
      emit(GetAppointmentDetailState.success(
          appointmentRecordEntity:
              appointmentRecord.copyWith(healthProvider: healthProvider)));
    } on ApiException catch (e) {
      emit(GetAppointmentDetailState.error(ApiException.getErrorMessage(e)));
    }
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

  _onCollectDataHealthProviderEvent(CollectDataHealthProviderEvent event,
      Emitter<AppointmentState> emit) async {
    emit(CreateAppointmentRecordState.initial());
    final int? providerId = event.appointmentRecordEntity.healthProvider?.id;
    final int userId = (await SharedPreferenceManager.getUser())!.id!;
    emit(CreateAppointmentRecordState.inProgress(
        createAppointmentRecordEntity: (state.data as AppointmentRecordEntity)
            .copyWith(
                user: UserEntity(id: userId),
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

  Future<void> _onUpdatePrescriptionEvent(
      UpdatePrescriptionEvent event, Emitter<AppointmentState> emit) async {
    emit(UpdatePrescriptionState.loading());
    try {
      final updatedAppointment =
          await appointmentUseCase.updateAppointmentRecord(event.appointment);
      emit(UpdatePrescriptionState.success(
          appointmentRecordEntity: updatedAppointment));
    } on ApiException catch (e) {
      emit(UpdatePrescriptionState.error(ApiException.getErrorMessage(e)));
    }
  }
}
