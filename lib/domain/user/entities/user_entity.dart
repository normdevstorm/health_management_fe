import 'package:health_management/domain/address/entities/address_entity.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';

import 'allergy_entity.dart';

class UserEntity {
  final int id;
  final String? lastName;
  final String? firstName;
  final DateTime? dateOfBirth;
  final String? avatarUrl;
  final List<AddressEntity>? addresses;
  final DoctorEntity? doctorProfile;
  final List<AppointmentRecordEntity>? appointmentRecords;
  final String? address;
  final String? photo;
  final List<AllergyEntity>? allergies;

  const UserEntity({
    required this.id,
    this.lastName,
    this.doctorProfile,
    this.appointmentRecords,
    this.address,
    this.photo,
    this.addresses,
    this.allergies,
    this.avatarUrl,
    this.dateOfBirth,
    this.firstName,
  });

  UserEntity copyWith(
      {int? id,
      String? lastName,
      String? phone,
      String? address,
      String? photo,
      String? firstName,
      DateTime? dateOfBirth,
      List<AddressEntity>? addresses,
      List<AppointmentRecordEntity>? appointmentRecords,
      String? avatarUrl,
      List<AllergyEntity>? allergies}) {
    return UserEntity(
      id: id ?? this.id,
      lastName: lastName ?? lastName,
      doctorProfile: doctorProfile ?? doctorProfile,
      appointmentRecords: appointmentRecords ?? this.appointmentRecords,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      addresses: addresses ?? this.addresses,
      allergies: allergies ?? this.allergies,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      firstName: firstName ?? this.firstName,
    );
  }
}
