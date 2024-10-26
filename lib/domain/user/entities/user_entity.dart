import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/domain/address/entities/address_entity.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'allergy_entity.dart';
part 'user_entity.freezed.dart';

@freezed
class UserEntity with  _$UserEntity {
  const factory UserEntity({
    required int id,
    String? lastName,
    String? firstName,
    DateTime? dateOfBirth,
    String? avatarUrl,
    List<AddressEntity>? addresses,
    DoctorEntity? doctorProfile,
    List<AppointmentRecordEntity>? appointmentRecords,
    String? address,
    String? photo,
    List<AllergyEntity>? allergies,
  }) = _UserEntity;
}
