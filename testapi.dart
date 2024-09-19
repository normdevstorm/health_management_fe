import 'package:health_management/app/di/injection.dart';
import 'package:health_management/data/auth/api/authentication_api.dart';
import 'package:health_management/data/auth/models/request/login_request_model.dart';
import 'package:health_management/data/auth/models/response/login_response_model.dart';
import 'package:health_management/data/common/api_response_model.dart';

void main() async {
  configureDependencies();
  AuthenticationApi api =  getIt.get<AuthenticationApi>();
  LoginResponse response = await api.login(
      const LoginRequest(email: "namuser4@gmail.com", password: "12345678"));
  print(response.toString());
}
