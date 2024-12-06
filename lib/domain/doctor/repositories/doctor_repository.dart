import 'package:health_management/domain/doctor/entities/doctor_entity.dart';

abstract class DoctorRepository {
  // Future<List<DoctorEntity>> getAllDoctor();
  Future<List<DoctorEntity>> getAllDoctorTopRated();
}
