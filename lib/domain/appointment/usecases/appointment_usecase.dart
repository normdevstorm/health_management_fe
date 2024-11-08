import '../entities/appointment_record_entity.dart';
import '../repositories/appointment_repository.dart';

class AppointmentUseCase {
  final AppointmentRepository _repository;

  AppointmentUseCase(this._repository);

  Future<List<AppointmentRecordEntity>> getAllAppointmentRecords() async {
    return _repository.getAllAppointmentRecords();
  }

  Future<AppointmentRecordEntity> createAppointmentRecord(AppointmentRecordEntity appointment) async {
    return _repository.createAppointmentRecord(appointment);
  }

  Future<AppointmentRecordEntity> updateAppointmentRecord(AppointmentRecordEntity appointment) async {
    return _repository.updateAppointmentRecord(appointment);
  }

  Future<String> deleteAppointmentRecord(int appointmentId) async {
    return _repository.deleteAppointmentRecord(appointmentId);
  }
}

