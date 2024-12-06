import 'package:health_management/domain/doctor/entities/doctor_entity.dart';

import '../repositories/doctor_repository.dart';

class DoctorUseCase {
  final DoctorRepository _repository;

  DoctorUseCase(this._repository);

  // Future<List<DoctorEntity>> getAllDoctor() async {
  //   return _repository.getAllDoctor();
  // }

  Future<List<DoctorEntity>> getAllDoctorTopRated() async {
    return _repository.getAllDoctorTopRated();
  }
}
