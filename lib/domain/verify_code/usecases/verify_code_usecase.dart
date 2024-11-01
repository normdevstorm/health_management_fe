import 'package:health_management/domain/verify_code/entities/validate_code_entity.dart';

import '../repositories/verify_code_repository.dart';

class VerifyCodeUseCase {
  final VerifyCodeRepository _repository;

  VerifyCodeUseCase(this._repository);

  Future<String> verifyCode(String email) async {
    return await _repository.verifyCode(email);
  }

  Future<String> validateCode(ValidateCodeEntity validateCodeEntity) async {
    return await _repository.validateCode(validateCodeEntity);
  }
}
