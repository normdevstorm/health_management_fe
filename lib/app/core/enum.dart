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
  @JsonValue("NEUROLOGIST")
  neurologist,
  @JsonValue("PEDIATRICIAN")
  pediatrician,
  @JsonValue("DIETICIAN")
  dietician,
  @JsonValue("PSYCHOLOGIST")
  psychologist,
}

enum ArticleStatus {
  @JsonValue("DRAFT")
  draft,
  @JsonValue("PUBLISHED")
  published,
}

enum ArticleCategory {
  @JsonValue("FITNESS")
  fitness,
  @JsonValue("NUTRITION")
  nutrition,
  @JsonValue("MENTAL_HEALTH")
  mentalHealth,
  @JsonValue("LIFESTYLE")
  lifestyle
}

enum VoteType {
  @JsonValue("UPVOTE")
  upvote,
  @JsonValue("DOWNVOTE")
  downvote,
}

enum MediaType {
  @JsonValue("IMAGE")
  image,
  @JsonValue("VIDEO")
  video,
  @JsonValue("AUDIO")
  audio
}

enum UploadImageType {
  @JsonValue("PROFILE")
  profile,
  @JsonValue("ARTICLE")
  article,
}

enum PaymentStatus {
  @JsonValue("PAYMENT_CANCELLED")
  cancelled,
  @JsonValue("PAYMENT_SUCCESS")
  success,
  @JsonValue("PAYMENT_FAILED")
  failed
}
