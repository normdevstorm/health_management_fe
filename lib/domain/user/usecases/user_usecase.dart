import '../../../app/app.dart';
import '../../../data/user/models/request/update_user_request.dart';
import '../../doctor/entities/doctor_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class UserUseCase {
  final UserRepository _repository;

  UserUseCase(this._repository);

  Future<String> deleteUser(int userId) async {
    return await _repository.deleteUser(userId);
  }

  Future<List<UserEntity>> getDoctors() async {
    return await _repository.getDoctors();
  }

  Future<List<UserEntity>> getPatients() async {
    return await _repository.getPatients();
  }

  Future<UserEntity> getUserSummary(int id) async {
    return await _repository.getUserSummary(id);
  }

  Future<UserEntity> updateUser(
      UpdateUserRequest updateUserRequest, int? userId) async {
    return await _repository.updateUser(updateUserRequest, userId);
  }

  Future<UserEntity> getUserByEmail(String email) async {
    return await _repository.getUserByEmail(email);
  }

  Future<List<DoctorEntity>> getTopRatedDoctors() async {
    return await _repository.getTopRatedDoctors();
  }

  // Future<UserEntity> getUserById() async {
  //   return await _repository.getUserById();
  // }

  Future<List<String>> uploadImageToFirebase(
      List<String> imgPath, UploadImageType ref) async {
    return await _repository.uploadImageToFirebase(imgPath, ref);
  }
}
