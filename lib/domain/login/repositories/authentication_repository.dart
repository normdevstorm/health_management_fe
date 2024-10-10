import 'package:health_management/data/common/api_response_model.dart';

import '../../../data/auth/models/request/login_request_model.dart';
import '../../../data/auth/models/request/register_request_model.dart';
import '../../../data/auth/models/response/login_response_model.dart';
import '../../../data/auth/models/response/register_response_model.dart';
abstract class AuthenticationRepository {
  Future<RegisterResponse?> register(RegisterRequest request);
  Future<LoginResponse?> login(LoginRequest request);
  Future<void> logout(String refreshToken);
  Future<ApiResponse?> getAppointment(int id);
  Future<LoginResponse?> refreshToken(String refreshToken);
}
