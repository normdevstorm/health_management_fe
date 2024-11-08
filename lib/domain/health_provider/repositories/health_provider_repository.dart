import 'package:health_management/domain/health_provider/entities/health_provider_entity.dart';


abstract class HealthProviderRepository {
  Future<List<HealthProviderEntity>> getAllHealthProvider();
  Future<HealthProviderEntity> createHealthProvider(
      HealthProviderEntity createDoctorRequest);
  Future<HealthProviderEntity> updateHealthProvider(
      HealthProviderEntity updateDoctorRequest);
  Future<HealthProviderEntity> addDoctorToProvider(
      int providerId, int doctorId);
  Future<HealthProviderEntity> removeDoctorFromProvider(
      int providerId, int doctorId);
}
