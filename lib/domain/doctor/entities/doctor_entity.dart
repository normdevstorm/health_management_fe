import 'package:freezed_annotation/freezed_annotation.dart';
part 'doctor_entity.freezed.dart';

@freezed
class DoctorEntity with _$DoctorEntity {
  const DoctorEntity._();
  const factory DoctorEntity({
    required int id,
    // required UserEntity user,
    String? specialization,
    double? experience,
    String? qualification,
    double? rating,
    String? about
  }) = _DoctorEntity;
  // final int id;
  // //todo: create user entitya
  // // final UserEntity user;
  // final String? specialization;
  // final double? experience;
  // final String? qualification;
  // final double? rating;
  // final String? about;

  // const DoctorEntity({
  //   required this.id,
  //   // required this.user,
  //   this.specialization,
  //   this.experience,
  //   this.qualification,
  //   this.rating,
  //   this.about
  // });

  // @override
  // List<Object?> get props => [
  //   id,
  //   // user,
  //   specialization,
  //   experience,
  //   qualification,
  //   rating,
  //   about
  // ];

  // DoctorEntity copyWith({
  //   int? id,
  //   // UserEntity? user,
  //   String? specialization,
  //   double? experience,
  //   String? qualification,
  //   double? rating,
  //   String? about
  // }) {
  //   return DoctorEntity(
  //     id: id ?? this.id,
  //     // user: user ?? this.user,
  //     specialization: specialization ?? this.specialization,
  //     experience: experience ?? this.experience,
  //     qualification: qualification ?? this.qualification,
  //     rating: rating ?? this.rating,
  //     about: about ?? this.about
  //   );
  // }
}
