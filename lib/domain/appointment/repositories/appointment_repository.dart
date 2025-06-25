import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';

abstract class AppointmentRepository {
  Future<List<AppointmentRecordEntity>> getAllAppointmentRecords();
  Future<AppointmentRecordEntity> getAppointmentRecordById(int appointmentId);
  Future<AppointmentRecordEntity> createAppointmentRecord(
      AppointmentRecordEntity appointment);
  Future<AppointmentRecordEntity> updateAppointmentRecord(
      AppointmentRecordEntity appointment);
  Future<String> deleteAppointmentRecord(int appointmentId);
  Future<List<AppointmentRecordEntity>> getAppointmentRecordByUserId(
      int userId);
  Future<List<AppointmentRecordEntity>> getAppointmentRecordByDoctorId(
      int doctorId);
  Future<String> cancelAppointmentRecord(int userId, int appointmentId);
}
