import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/domain/verify_code/entities/verify_code_entity.dart';
part 'verify_code_request.freezed.dart';
part 'verify_code_request.g.dart';
@freezed
class VerifyCodeRequest with _$VerifyCodeRequest {
   const VerifyCodeRequest._();
  factory VerifyCodeRequest({
    required String email,
  }) = _VerifyCodeRequest;

  factory VerifyCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeRequestFromJson(json);

  VerifyCodeRequest fromEntity(VerifyCodeEntity entity) {
    return VerifyCodeRequest(
      email: entity.email,
    );
  }
}