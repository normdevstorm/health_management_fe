import 'package:dio/dio.dart';
import 'package:health_management/data/verify_code/models/request/validate_code_request.dart';
import 'package:health_management/data/verify_code/models/response/verify_code_response.dart';
import 'package:retrofit/retrofit.dart';

import '../models/request/verify_code_request.dart';

part 'verify_code_api.g.dart';

@RestApi()
abstract class VerifyCodeApi {
  factory VerifyCodeApi(Dio dio, {String baseUrl}) = _VerifyCodeApi;

  @POST('/mail/verify_code')
  Future<VerifyCodeResponse> verifyCode(@Body() VerifyCodeRequest email);

  @POST('/mail/validate_code')
  Future<VerifyCodeResponse> validateCode(@Body() ValidateCodeRequest validateCodeRequest);
}

