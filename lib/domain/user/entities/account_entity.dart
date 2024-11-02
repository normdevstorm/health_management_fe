import 'package:health_management/app/app.dart';
import 'package:json_annotation/json_annotation.dart';
part 'account_entity.g.dart';
@JsonSerializable()
class AccountEntity {
  final int id;
  final String? username;
  final String? email;
  final String? password;
  final String? name;
  final String? phone;
  final Role? role;
  final AccountStatus? status;

  AccountEntity({
    required this.id,
    this.username,
    this.email,
    this.password,
    this.name,
    this.phone,
    this.role,
    this.status,
  });

  AccountEntity copyWith({
    int? id,
    String? username,
    String? email,
    String? name,
    String? password,
    String? phone,
    Role? role,
    AccountStatus? status,
  }) {
    return AccountEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }

  factory AccountEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AccountEntityToJson(this);
}
