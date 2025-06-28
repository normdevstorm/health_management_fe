import 'package:health_management/domain/doctor_schedule/entities/doctor_schedule_entity.dart';

abstract class DoctorScheduleRepository {
  Future<List<DoctorScheduleEntity>> getDoctorSchedule(
      int doctorId, int patientId);
  Future<List<int>> exportDoctorSchedules(
      int doctorId, String startDate, String? endDate);
}
