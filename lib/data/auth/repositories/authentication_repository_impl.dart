import 'package:health_management/app/di/injection.dart';
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
      logger.e(e);
    }
    return null;
  }

  @override
  Future<LoginResponse?> login(LoginRequest request) async {
    try {
      LoginResponse? apiResponse = await api.login(request);
      return apiResponse;
    } catch (e) {
      logger.e(e);
    }
    return null;
  }
}
