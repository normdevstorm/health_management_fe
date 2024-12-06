import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:logger/logger.dart';

import '../../../domain/doctor/repositories/doctor_repository.dart';
import '../api/doctor_api.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorApi api;
  final Logger logger;

  DoctorRepositoryImpl(this.api, this.logger);

  // @override
  // Future<List<DoctorEntity>> getAllDoctor() {}

  @override
  Future<List<DoctorEntity>> getAllDoctorTopRated() async {
    try {
      final response = await api.getAllDoctorTopRated();
      return (response.data ?? []).map((e) => e.toEntity()).toList();
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }
}
