import 'package:health_management/domain/verify_code/entities/validate_code_entity.dart';

abstract class VerifyCodeRepository {
  Future<String> verifyCode(String email);
  Future<String> validateCode(ValidateCodeEntity validateCodeEntity);
}
