import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/verify_code/entities/validate_code_entity.dart';
part 'validate_code_request.freezed.dart';
part 'validate_code_request.g.dart';
@freezed
class ValidateCodeRequest with _$ValidateCodeRequest {
  const ValidateCodeRequest._();
  factory ValidateCodeRequest({
    required String code,
   required String email,
  }) = _ValidateCodeRequest;


  factory ValidateCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidateCodeRequestFromJson(json);

  ValidateCodeRequest fromEntity(ValidateCodeEntity entity) {
    return ValidateCodeRequest(
      code: entity.code,
      email: entity.email,
    );
  } 
}