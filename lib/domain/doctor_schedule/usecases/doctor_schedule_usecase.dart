import '../entities/doctor_schedule_entity.dart';
import '../repositories/doctor_schedule_repository.dart';

class DoctorScheduleUseCase {
  final DoctorScheduleRepository _repository;

  DoctorScheduleUseCase(this._repository);

  Future<List<DoctorScheduleEntity>> getDoctorSchedule(int doctorId) {
    return _repository.getDoctorSchedule(doctorId);
  }

  Future<List<int>> exportDoctorSchedules(
      int doctorId, String startDate, String? endDate) {
    return _repository.exportDoctorSchedules(doctorId, startDate, endDate);
  }
}
