
  import 'dart:ffi';

import 'package:health_management/data/user/models/response/user_response.dart';

import '../../../data/doctor/models/response/doctor_response.dart';
import '../../../data/user/models/request/update_user_request.dart';
import '../../../data/user/models/response/user_summary_response.dart';

abstract class UserRepository {
    Future<List<UserResponse>> getDoctors();
    Future<List<UserResponse>> getPatients();
    Future<String> deleteUser(Long userId);
    Future<UserSummaryResponse> getUserSummary(Long id);
    Future<UserResponse> updateUser(UpdateUserRequest updateUserRequest, Long userId);
    Future<UserSummaryResponse> getUserByEmail(String email);
    Future<List<DoctorResponse>> getTopRatedDoctors();
}

