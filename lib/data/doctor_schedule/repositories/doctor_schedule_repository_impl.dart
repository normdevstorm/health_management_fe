import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/domain/doctor_schedule/entities/doctor_schedule_entity.dart';
import 'package:logger/logger.dart';

import '../../../domain/doctor_schedule/repositories/doctor_schedule_repository.dart';
import '../api/doctor_schedule_api.dart';

class DoctorScheduleRepositoryImpl implements DoctorScheduleRepository {
  final DoctorScheduleApi api;
  final Logger logger;

  DoctorScheduleRepositoryImpl(this.api, this.logger);

  @override
  Future<List<DoctorScheduleEntity>> getDoctorSchedule(int doctorId) async {
    try {
      final response = await api.getDoctorSchedule(doctorId);
      return response.data!.map((e) => e.toEntity()).toList();
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<List<int>> exportDoctorSchedules(
      int doctorId, String startDate, String? endDate) async {
    try {
      final response =
          await api.exportDoctorSchedules(doctorId, startDate, endDate);
      return response.data;
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }
}
