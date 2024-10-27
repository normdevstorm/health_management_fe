
  import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';

abstract class AppointmentRepository {
    Future<List<AppointmentRecordEntity>> getAllAppointmentRecords();
    Future<AppointmentRecordEntity> createAppointmentRecord(AppointmentRecordEntity appointment);
    Future<AppointmentRecordEntity> updateAppointmentRecord(AppointmentRecordEntity appointment);
    Future<String> deleteAppointmentRecord(String appointmentId);
}

