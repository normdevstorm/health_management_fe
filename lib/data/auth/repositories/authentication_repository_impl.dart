import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/data/auth/models/request/login_request_model.dart';
import 'package:health_management/data/auth/models/response/login_response_model.dart';
import 'package:logger/logger.dart';

import '../../../domain/login/repositories/authentication_repository.dart';
import '../../common/api_response_model.dart';
import '../api/authentication_api.dart';
import '../models/request/register_request_model.dart';
import '../models/response/register_response_model.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationApi api;
  final Logger logger;

  AuthenticationRepositoryImpl(this.api, this.logger);
  @override
  Future<RegisterResponse?> register(RegisterRequest request) async {
    try {
      ApiResponse<RegisterResponse> apiResponse = await api.register(request);
      RegisterResponse? registerResponse = apiResponse.data;
      return registerResponse;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<LoginResponse?> login(LoginRequest request) async {
    try {
      LoginResponse apiResponse = await api.login(request);
      SharedPreferenceManager.setUserId(apiResponse.userId);
      SharedPreferenceManager.setAccessToken(apiResponse.accessToken);
      SharedPreferenceManager.setRefreshToken(apiResponse.refreshToken);
      return apiResponse;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<LoginResponse?> refreshToken(String refreshToken) async {
    try {
      LoginResponse loginResponse =
          await api.refreshToken({"refresh_token": refreshToken});
      return loginResponse;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<void> logout(String refreshToken) async {
    try {
      await api.logout({"refresh_token": refreshToken});
      await SharedPreferenceManager.deleteAccessToken();
      await SharedPreferenceManager.deleteRefreshToken();
      await SharedPreferenceManager.deleteUserId();
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }
}
