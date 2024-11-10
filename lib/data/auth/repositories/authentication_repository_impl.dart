import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/app/managers/session_manager.dart';
import 'package:health_management/data/auth/models/request/login_request_model.dart';
import 'package:health_management/data/auth/models/response/login_response_model.dart';
import 'package:health_management/data/auth/models/response/refresh_response_model.dart';
import 'package:health_management/domain/auth/entities/login_entity.dart';
import 'package:health_management/domain/auth/entities/register_entity.dart';
import 'package:logger/logger.dart';
import '../../../domain/auth/repositories/authentication_repository.dart';
import '../api/authentication_api.dart';
import '../models/request/register_request_model.dart';
import '../models/response/register_response_model.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationApi api;
  final Logger logger;

  AuthenticationRepositoryImpl(this.api, this.logger);
  @override
  Future<RegisterEntity> register(RegisterRequest request) async {
    try {
      RegisterResponse? registerResponse = await api.register(request);
      RegisterEntity registerEntity = registerResponse.toEntity();
      SessionManager().setSession(
          LoginEntity(
              accessToken: registerEntity.accessToken,
              refreshToken: registerEntity.refreshToken),
          true);
      return registerEntity;
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<LoginResponse?> login(LoginRequest request) async {
    try {
      LoginResponse apiResponse = await api.login(request);
      await SharedPreferenceManager.setUser(apiResponse.userResponse.toEntity());
      SessionManager().setSession(
          LoginEntity(
              accessToken: apiResponse.accessToken,
              refreshToken: apiResponse.refreshToken),
          true);
      return apiResponse;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<LoginEntity?> refreshToken(String refreshToken) async {
    try {
      final response = await api.refreshToken({"refresh_token": refreshToken});
      if(response.data == null) {
        throw ApiException.defaultError("Failed to refresh token");
      }
      RefreshResponse refreshResponse = response.data! ;
       SessionManager().setSession(
          LoginEntity(
              accessToken: refreshResponse.accessToken,
              refreshToken: refreshResponse.refreshToken),
          true);
      return LoginEntity(
          accessToken: refreshResponse.accessToken,
          refreshToken: refreshResponse.refreshToken,);
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await api.logout();
      SessionManager().clearSession();
      await SharedPreferenceManager.deleteUserId();
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }
}
