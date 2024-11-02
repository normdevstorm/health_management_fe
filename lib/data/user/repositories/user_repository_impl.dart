import 'dart:ffi';

import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/data/common/api_response_model.dart';
import 'package:health_management/data/doctor/models/response/doctor_response.dart';
import 'package:health_management/data/user/models/request/update_user_request.dart';
import 'package:health_management/data/user/models/response/user_response.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/domain/user/repositories/user_repository.dart';
import 'package:logger/logger.dart';

import '../../../domain/chat/user/user_repository.dart';
import '../api/user_api.dart';
import '../models/response/user_summary_response.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApi api;
  final Logger logger;

  UserRepositoryImpl(this.api, this.logger);

  @override
  Future<String> deleteUser(Long userId) async  {
    try {
      return await api.deleteUser(userId);
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<List<UserEntity>> getDoctors() async {
    try {
      ApiResponse apiResponse = await api.getDoctors();
      List<UserEntity> doctors = (apiResponse.data as List<UserResponse>)
          .map((doctor) => doctor.toEntity())
          .toList();
      return doctors;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<List<UserEntity>> getPatients() async {
    try {
      ApiResponse apiResponse = await api.getPatients();
      List<UserEntity> patients = (apiResponse.data as List<UserResponse>)
          .map((patient) => patient.toEntity())
          .toList();
      return patients;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<List<DoctorEntity>> getTopRatedDoctors() async {
    try {
      ApiResponse apiResponse = await api.getTopRatedDoctors();
      List<DoctorEntity> doctors = (apiResponse.data as List<DoctorResponse>)
          .map((doctor) => doctor.toEntity())
          .toList();
      return doctors;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<UserEntity> getUserByEmail(String email) async {
    try {
      ApiResponse apiResponse = await api.getUserByEmail(email);
      UserEntity user = (apiResponse.data as UserSummaryResponse).toEntity();
      return user;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<UserEntity> getUserSummary(Long id) async {
    try {
      ApiResponse apiResponse = await api.getUserSummary(id);
      UserEntity user = (apiResponse.data as UserSummaryResponse).toEntity();
      return user;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<UserEntity> updateUser(
      UpdateUserRequest updateUserRequest, Long userId) async {
    try {
      ApiResponse apiResponse = await api.updateUser(updateUserRequest, userId);
      UserEntity user = (apiResponse.data as UserResponse).toEntity();
      return user;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }
}
