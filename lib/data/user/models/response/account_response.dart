import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/domain/user/entities/account_entity.dart';
part 'account_response.g.dart';

@JsonSerializable()
class AccountResponse {
  final int id;
  final String? email;
  final String? username;
  final Role? role;
  final String? phone;
  final AccountStatus? status;

  AccountResponse({
    required this.id,
    this.email,
    this.username,
    this.role,
    this.phone,
    this.status,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResponseToJson(this);

  AccountEntity toEntity() {
    return AccountEntity(
      id: id,
      email: email,
      username: username,
      role: role,
      phone: phone,
      status: status,
    );
  }
}
