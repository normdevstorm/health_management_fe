import 'package:health_management/domain/address/entities/address_entity.dart';
import 'package:health_management/domain/user/entities/account_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_update_entity.g.dart';

@JsonSerializable()
class UserUpdateEntity {
  final int id;
  final String? firstName;
  final String? lastName;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? avatarUrl;
  final AccountEntity? account;
  final List<AddressEntity>? addresses;

  UserUpdateEntity(
      {required this.id,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.gender,
      this.avatarUrl,
      this.account,
      this.addresses});

  UserUpdateEntity copyWith({
    int? id,
    String? lastName,
    String? firstName,
    DateTime? dateOfBirth,
    String? avatarUrl,
    String? gender,
    AccountEntity? account,
    List<AddressEntity>? addresses,
  }) {
    return UserUpdateEntity(
        id: id ?? this.id,
        lastName: lastName ?? this.lastName,
        firstName: firstName ?? this.firstName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        gender: gender ?? this.gender,
        account: account ?? this.account,
        addresses: addresses ?? this.addresses);
  }

  factory UserUpdateEntity.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserUpdateEntityToJson(this);
}
