import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/domain/address/entities/address_entity.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/domain/user/entities/account_entity.dart';
import 'allergy_entity.dart';
part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  final int id;
  final String? lastName;
  final String? firstName;
  final DateTime? dateOfBirth;
  final String? avatarUrl;
  final String? gender;
  final AccountEntity? account;
  final List<AddressEntity>? addresses;
  final DoctorEntity? doctorProfile;
  final List<AppointmentRecordEntity>? appointmentRecords;
  final String? address;
  final String? photo;
  final List<AllergyEntity>? allergies;

  UserEntity({
    required this.id,
    this.lastName,
    this.firstName,
    this.dateOfBirth,
    this.avatarUrl,
    this.gender,
    this.account,
    this.addresses,
    this.doctorProfile,
    this.appointmentRecords,
    this.address,
    this.photo,
    this.allergies,
  });

  UserEntity copyWith({
    int? id,
    String? lastName,
    String? firstName,
    DateTime? dateOfBirth,
    String? avatarUrl,
    String? gender,
    AccountEntity? account,
    List<AddressEntity>? addresses,
    DoctorEntity? doctorProfile,
    List<AppointmentRecordEntity>? appointmentRecords,
    String? address,
    String? photo,
    List<AllergyEntity>? allergies,
  }) {
    return UserEntity(
      id: id ?? this.id,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      gender: gender ?? this.gender,
      account: account ?? this.account,
      addresses: addresses ?? this.addresses,
      doctorProfile: doctorProfile ?? this.doctorProfile,
      appointmentRecords: appointmentRecords ?? this.appointmentRecords,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      allergies: allergies ?? this.allergies,
    );
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
