import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import '../../../data/user/models/request/update_user_request.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getDoctors();
  Future<List<UserEntity>> getPatients();
  Future<String> deleteUser(int userId);
  Future<UserEntity> getUserSummary(int id);
  Future<UserEntity> updateUser(
      UpdateUserRequest updateUserRequest, int userId);
  Future<UserEntity> getUserByEmail(String email);
  Future<List<DoctorEntity>> getTopRatedDoctors();
}
