import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../app/app.dart';
part 'allergy_entity.freezed.dart';

@freezed
class AllergyEntity with _$AllergyEntity {
  const AllergyEntity._();
  const factory AllergyEntity({
  required int id,
    AllergyType? allergyType,
    String? severity,
    String? note,
  }) = _AllergyEntity;

}
