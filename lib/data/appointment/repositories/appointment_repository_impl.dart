import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/data/appointment/models/request/appointment_record_request.dart';
import 'package:health_management/data/appointment/models/request/update_appointment_record_request.dart';
import 'package:logger/logger.dart';

import '../../../domain/appointment/entities/appointment_record_entity.dart';
import '../../../domain/appointment/repositories/appointment_repository.dart';
import '../api/appointment_api.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentApi api;
  final Logger logger;

  AppointmentRepositoryImpl(this.api, this.logger);

  @override
  Future<List<AppointmentRecordEntity>> getAllAppointmentRecords() async {
    try {
      final response = await api.getAllAppointmentRecords();
      return (response.data ?? []).map((e) => e.toEntity()).toList();
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<AppointmentRecordEntity> createAppointmentRecord(AppointmentRecordEntity appointment) async {
    try {
      final response = await api.createAppointmentRecord(AppointmentRecordRequest.fromEntity(appointment));
      return response.data?.toEntity() ?? const AppointmentRecordEntity();
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<AppointmentRecordEntity> updateAppointmentRecord(AppointmentRecordEntity appointment) async {
    try {
      final response = await api.updateAppointmentRecord(UpdateAppointmentRecordRequest.fromEntity(appointment));
      return response.data?.toEntity() ?? const AppointmentRecordEntity();
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<String> deleteAppointmentRecord(String appointmentId) async {
    try {
      final response = await api.deleteAppointmentRecord(appointmentId);
      return response.data!;
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }
}
