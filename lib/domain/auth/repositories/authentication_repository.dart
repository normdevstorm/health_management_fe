import 'package:health_management/domain/auth/entities/register_entity.dart';

import '../../../data/auth/models/request/login_request_model.dart';
import '../../../data/auth/models/request/register_request_model.dart';
import '../../../data/auth/models/response/login_response_model.dart';

abstract class AuthenticationRepository {
  Future<RegisterEntity> register(RegisterRequest request);
  Future<LoginResponse?> login(LoginRequest request);
  Future<void> logout();
  Future<LoginResponse?> refreshToken(String refreshToken);
}
