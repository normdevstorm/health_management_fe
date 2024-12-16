import 'package:health_management/domain/user/entities/user_entity.dart';

abstract class DoctorRepository {
  // Future<List<DoctorEntity>> getAllDoctor();
  Future<List<UserEntity>> getAllDoctorTopRated();
}
