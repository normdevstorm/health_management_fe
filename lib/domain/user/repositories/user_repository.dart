
  import 'dart:ffi';

import 'package:health_management/data/user/models/response/user_response.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';

import '../../../data/doctor/models/response/doctor_response.dart';
import '../../../data/user/models/request/update_user_request.dart';
import '../../../data/user/models/response/user_summary_response.dart';

abstract class UserRepository {
    Future<List<UserEntity>> getDoctors();
    Future<List<UserEntity>> getPatients();
    Future<String> deleteUser(Long userId);
    Future<UserEntity> getUserSummary(Long id);
    Future<UserEntity> updateUser(UpdateUserRequest updateUserRequest, Long userId);
    Future<UserEntity> getUserByEmail(String email);
    Future<List<DoctorEntity>> getTopRatedDoctors();
}

