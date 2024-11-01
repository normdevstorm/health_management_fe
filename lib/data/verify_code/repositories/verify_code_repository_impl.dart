import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/data/verify_code/models/request/validate_code_request.dart';
import 'package:health_management/data/verify_code/models/request/verify_code_request.dart';
import 'package:health_management/domain/verify_code/entities/validate_code_entity.dart';
import 'package:logger/logger.dart';

import '../../../domain/verify_code/repositories/verify_code_repository.dart';
import '../api/verify_code_api.dart';
import '../models/response/verify_code_response.dart';

class VerifyCodeRepositoryImpl implements VerifyCodeRepository {
  final VerifyCodeApi api;
  final Logger logger;

  VerifyCodeRepositoryImpl(this.api, this.logger);

  @override
  Future<String> verifyCode(String email) async {
    try {
      await api.verifyCode(VerifyCodeRequest(email: email));
      return "Code sent successfully";
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<String> validateCode(ValidateCodeEntity validateCodeEntity) async {
    try {
      VerifyCodeResponse verifyCodeResponse = await api.validateCode(
          ValidateCodeRequest(
              code: validateCodeEntity.code, email: validateCodeEntity.email));
      return verifyCodeResponse.message;
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }
}
