import '../entities/health_provider_entity.dart';
import '../repositories/health_provider_repository.dart';

class HealthProviderUseCase {
  final HealthProviderRepository _repository;

  HealthProviderUseCase(this._repository);

  Future<List<HealthProviderEntity>> getAllHealthProvider() async {
    return _repository.getAllHealthProvider();
  }

  Future<HealthProviderEntity> createHealthProvider(HealthProviderEntity createDoctorRequest) async {
    return _repository.createHealthProvider(createDoctorRequest);
  }

  Future<HealthProviderEntity> updateHealthProvider(HealthProviderEntity updateDoctorRequest) async {
    return _repository.updateHealthProvider(updateDoctorRequest);
  }

  Future<HealthProviderEntity> addDoctorToProvider(int providerId, int doctorId) async {
    return _repository.addDoctorToProvider(providerId, doctorId);
  }

  Future<HealthProviderEntity> removeDoctorFromProvider(int providerId, int doctorId) async {
    return _repository.removeDoctorFromProvider(providerId, doctorId);
  }
}
