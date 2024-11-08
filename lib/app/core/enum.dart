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
  success,
  //use for create, update= flow
  @JsonValue('IN_PROGRESS')
  inProgress
}

enum HospitalSpecialty {
  @JsonValue('EMERGENCY_MEDICINE')
  emergencyMedicine,

  @JsonValue('INTERNAL_MEDICINE')
  internalMedicine,

  @JsonValue('PEDIATRICS')
  pediatrics,

  @JsonValue('SURGERY')
  surgery,

  @JsonValue('OBSTETRICS_AND_GYNECOLOGY')
  obstetricsAndGynecology,

  @JsonValue('CARDIOLOGY')
  cardiology,

  @JsonValue('NEUROLOGY')
  neurology,

  @JsonValue('ORTHOPEDICS')
  orthopedics,

  @JsonValue('ONCOLOGY')
  oncology,

  @JsonValue('RADIOLOGY')
  radiology,

  @JsonValue('ANESTHESIOLOGY')
  anesthesiology,

  @JsonValue('GASTROENTEROLOGY')
  gastroenterology,

  @JsonValue('ENDOCRINOLOGY')
  endocrinology,

  @JsonValue('PSYCHIATRY')
  psychiatry,

  @JsonValue('PULMONOLOGY')
  pulmonology,

  @JsonValue('NEPHROLOGY')
  nephrology,

  @JsonValue('DERMATOLOGY')
  dermatology,

  @JsonValue('UROLOGY')
  urology,

  @JsonValue('RHEUMATOLOGY')
  rheumatology,

  @JsonValue('INFECTIOUS_DISEASE')
  infectiousDisease,
}