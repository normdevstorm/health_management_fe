import 'package:health_management/domain/auth/entities/login_entity.dart';
import 'package:health_management/domain/auth/entities/register_entity.dart';
import 'package:health_management/domain/auth/repositories/authentication_repository.dart';

import '../../../data/auth/models/request/login_request_model.dart';
import '../../../data/auth/models/request/register_request_model.dart';
import '../../../data/auth/models/response/login_response_model.dart';

class AuthenticationUsecase {
  final AuthenticationRepository _authenticationRepository;
  AuthenticationUsecase(this._authenticationRepository);

  Future<RegisterEntity?> register(RegisterRequest request) async {
    return await _authenticationRepository.register(request);
  }

  Future<LoginEntity?> login(LoginRequest request) async {
    LoginResponse? loginResponse =
        await _authenticationRepository.login(request);
    return LoginEntity(
        accessToken: loginResponse?.accessToken,
        refreshToken: loginResponse?.refreshToken);
  }

  Future<LoginEntity?> refreshToken(String refreshToken) async {
    LoginResponse? loginResponse =
        await _authenticationRepository.refreshToken(refreshToken);
    return LoginEntity(
        accessToken: loginResponse?.accessToken,
        refreshToken: loginResponse?.refreshToken);
  }

  Future<void> logout() async {
    await _authenticationRepository.logout();
  }
}
