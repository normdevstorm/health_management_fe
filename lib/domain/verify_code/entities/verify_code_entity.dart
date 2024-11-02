import 'package:json_annotation/json_annotation.dart';
part 'verify_code_entity.g.dart';

@JsonSerializable()
class VerifyCodeEntity {
  final String email;

  VerifyCodeEntity({required this.email});

  factory VerifyCodeEntity.fromJson(Map<String, dynamic> json) => _$VerifyCodeEntityFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyCodeEntityToJson(this);

  VerifyCodeEntity copyWith({String? email}) {
    return VerifyCodeEntity(
      email: email ?? this.email,
    );
  }
}