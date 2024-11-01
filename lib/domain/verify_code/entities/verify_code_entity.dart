import 'package:freezed_annotation/freezed_annotation.dart';
part 'verify_code_entity.freezed.dart';
@freezed
class VerifyCodeEntity with _$VerifyCodeEntity {
  const VerifyCodeEntity._();
  factory VerifyCodeEntity({
    required String email,
  }) = _VerifyCodeEntity;
}