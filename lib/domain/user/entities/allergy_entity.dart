import 'package:json_annotation/json_annotation.dart';
import '../../../app/app.dart';
part 'allergy_entity.g.dart';

@JsonSerializable()
class AllergyEntity {
  final int id;
  final AllergyType? allergyType;
  final String? severity;
  final String? note;

  AllergyEntity({
    required this.id,
    this.allergyType,
    this.severity,
    this.note,
  });

  AllergyEntity copyWith({
    int? id,
    AllergyType? allergyType,
    String? severity,
    String? note,
  }) {
    return AllergyEntity(
      id: id ?? this.id,
      allergyType: allergyType ?? this.allergyType,
      severity: severity ?? this.severity,
      note: note ?? this.note,
    );
  }

  factory AllergyEntity.fromJson(Map<String, dynamic> json) => _$AllergyEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AllergyEntityToJson(this);
}
