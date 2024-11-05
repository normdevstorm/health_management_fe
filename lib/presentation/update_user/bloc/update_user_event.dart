// profile_event.dart
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện gửi yêu cầu cập nhật hồ sơ
class ProfileUpdateSubmitted extends ProfileEvent {
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;
  final String avatarUrl;
  final UpdateAccountRequest account;
  final Set<AddressDTO> addresses;
  final DoctorDTO? doctorProfile;
  final int userId;
  final String role;

  const ProfileUpdateSubmitted({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.avatarUrl,
    required this.account,
    required this.addresses,
    this.doctorProfile,
    required this.userId,
    required this.role,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        dateOfBirth,
        gender,
        avatarUrl,
        account,
        addresses,
        doctorProfile,
        userId,
        role
      ];
}

// Dữ liệu yêu cầu cập nhật tài khoản
class UpdateAccountRequest {
  final String username;
  final String email;
  final String password;
  final String phone;

  const UpdateAccountRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
  });
}

// Dữ liệu địa chỉ người dùng
class AddressDTO {
  final int id;
  final String unitNumber;
  final String streetNumber;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String region;
  final String postalCode;
  final String country;
  final bool isDefault;

  const AddressDTO({
    required this.id,
    required this.unitNumber,
    required this.streetNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.region,
    required this.postalCode,
    required this.country,
    required this.isDefault,
  });
}

// Dữ liệu hồ sơ bác sĩ
class DoctorDTO {
  final int id;
  final String specialization;
  final double experience;
  final String qualification;
  final double rating;
  final String about;

  const DoctorDTO({
    required this.id,
    required this.specialization,
    required this.experience,
    required this.qualification,
    required this.rating,
    required this.about,
  });
}
