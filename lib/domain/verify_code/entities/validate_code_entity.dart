import 'package:freezed_annotation/freezed_annotation.dart';
part 'validate_code_entity.freezed.dart';
@freezed
class ValidateCodeEntity with _$ValidateCodeEntity {
  const ValidateCodeEntity._();
  factory ValidateCodeEntity({
    required String code,
    required String email,
  }) = _ValidateCodeEntity;
}