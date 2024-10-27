//todo: move into a sepatate directory in case this enitty used for its dedicated feature
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app/app.dart';
part 'medical_condition.freezed.dart';
part 'medical_condition.g.dart';
@freezed
class MedicalCondition with _$MedicalCondition {
  const MedicalCondition._();
  const factory MedicalCondition({
     int? id,
     String? conditionName,
     MedicalConditionStatus? medicalConditionStatus,
     String? description,
  }) = _MedicalCondition;

  factory MedicalCondition.fromJson(Map<String, dynamic> json) => _$MedicalConditionFromJson(json);
}