part of '../app.dart';

enum Role {
  @JsonValue('ADMIN')
  admin,
  @JsonValue('USER')
  user,
  @JsonValue('DOCTOR')
  doctor
}

enum AppointmentType {
  @JsonValue('TELEMEDICINE')
  telemedicine,
  @JsonValue('IN_PERSON')
  inPerson
}

enum AppointmentStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('SCHEDULED')
  scheduled,
  @JsonValue('CANCELLED')
  cancelled,
  @JsonValue('COMPLETED')
  completed,

}

enum MedicalConditionStatus {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('RESOLVED')
  resolved
}

enum AllergyType {
  @JsonValue('PEANUTS')
  peanuts,
  @JsonValue('SHELLFISH')
  shellfish,
  @JsonValue('DAIRY')
  dairy,
  @JsonValue('GLUTEN')
  gluten,
  @JsonValue('POLLEN')
  pollen,
  @JsonValue('DUST')
  dust,
  @JsonValue('LATEX')
  latex,
  @JsonValue('INSECT_STINGS')
  insectStings,
  @JsonValue('MEDICATIONS')
  medications,
  @JsonValue('MOLD')
  mold,
  @JsonValue('PET_DANDER')
  petDander
}

enum AccountStatus {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('INACTIVE')
  inactive
}

enum BlocStatus {
  @JsonValue('INITIAL')
  initial,
  @JsonValue('LOADING')
  loading,
  @JsonValue('LOADED')
  loaded,
  @JsonValue('ERROR')
  error,
  @JsonValue('SUCCESS')
  success
}
