import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/data/health_provider/models/request/health_provider_request.dart';
import 'package:health_management/domain/health_provider/entities/health_provider_entity.dart';
import 'package:logger/logger.dart';

import '../../../domain/health_provider/repositories/health_provider_repository.dart';
import '../api/health_provider_api.dart';

class HealthProviderRepositoryImpl implements HealthProviderRepository {
  final HealthProviderApi api;
  final Logger logger;

  HealthProviderRepositoryImpl(this.api, this.logger);

  @override
  Future<HealthProviderEntity> addDoctorToProvider(
      int providerId, int doctorId) async {
    try {
      final response = await api.addDoctor(providerId, doctorId);
      return response.data?.toEntity() ?? HealthProviderEntity();
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<HealthProviderEntity> createHealthProvider(
      HealthProviderEntity createDoctorRequest) async {
    try {
      final response = await api.createHealthProvider(
          HealthProviderRequest.fromEntity(createDoctorRequest));
      return response.data?.toEntity() ?? HealthProviderEntity();
    } catch (e) {
      logger.e(e);

      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<List<HealthProviderEntity>> getAllHealthProvider() async {
    try {
      final response = await api.getAllHealthProviders();
      return response.data?.map((e) => e.toEntity()).toList() ?? [];
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<HealthProviderEntity> removeDoctorFromProvider(
      int providerId, int doctorId) async {
    try {
      final response =
          await api.doctorLeaveHealthProvider(providerId, doctorId);

      return response.data?.toEntity() ?? HealthProviderEntity();
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<HealthProviderEntity> updateHealthProvider(
      HealthProviderEntity updateDoctorRequest) async {
    try {
      final response = await api.updateHealthProvider(
          HealthProviderRequest.fromEntity(updateDoctorRequest));
      return response.data?.toEntity() ?? HealthProviderEntity();
    } catch (e) {
      logger.e(e);

      throw ApiException.getDioException(e);
    }
  }
}
