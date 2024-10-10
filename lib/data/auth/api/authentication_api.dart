import 'package:dio/dio.dart';
import 'package:health_management/data/auth/models/request/register_request_model.dart';
import 'package:health_management/data/auth/models/response/register_response_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../common/api_response_model.dart';
import '../models/request/login_request_model.dart';
import '../models/response/login_response_model.dart';

part 'authentication_api.g.dart';

@RestApi()
abstract class AuthenticationApi {
  factory AuthenticationApi(Dio dio, {String baseUrl}) = _AuthenticationApi;

  @POST('/auth/register')
  Future<ApiResponse<RegisterResponse>> register(@Body() RegisterRequest request);

  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST('/auth/logout')
  Future<void> logout(@Body() Map<String, String> refreshToken);

  @POST('/auth/refresh-token')
  Future<LoginResponse> refreshToken(@Body() Map<String, String> refreshToken);

  @GET('/appointment/{id}')
  Future<ApiResponse> getAppointment(@Path('id') int id);

}

