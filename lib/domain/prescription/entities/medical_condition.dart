//todo: move into a sepatate directory in case this enitty used for its dedicated feature
import 'package:equatable/equatable.dart';

import '../../../app/app.dart';

class MedicalCondition extends Equatable {
  final int id;
  final String conditionName;
  final MedicalConditionStatus medicalConditionStatus;
  final String description;

  MedicalCondition({
    required this.id,
    required this.conditionName,
    required this.medicalConditionStatus,
    required this.description,
  });

  @override
  List<Object?> get props => [
    id,
    conditionName,
    medicalConditionStatus,
    description,
  ];

  MedicalCondition copyWith({
    int? id,
    String? conditionName,
    MedicalConditionStatus? medicalConditionStatus,
    String? description,
  }) {
    return MedicalCondition(
      id: id ?? this.id,
      conditionName: conditionName ?? this.conditionName,
      medicalConditionStatus: medicalConditionStatus ?? this.medicalConditionStatus,
      description: description ?? this.description,
    );
  }
}