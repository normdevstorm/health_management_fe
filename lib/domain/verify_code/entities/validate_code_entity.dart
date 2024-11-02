import 'package:json_annotation/json_annotation.dart';
part 'validate_code_entity.g.dart';

@JsonSerializable()
class ValidateCodeEntity {
  final String code;
  final String email;

  ValidateCodeEntity({required this.code, required this.email});

  factory ValidateCodeEntity.fromJson(Map<String, dynamic> json) => _$ValidateCodeEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ValidateCodeEntityToJson(this);

  ValidateCodeEntity copyWith({String? code, String? email}) {
    return ValidateCodeEntity(
      code: code ?? this.code,
      email: email ?? this.email,
    );
  }
}