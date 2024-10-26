import 'package:equatable/equatable.dart';

import '../../../app/app.dart';

class AllergyEntity extends Equatable {
  //todo: Check if id is needed later on
  // final int id;
  final AllergyType? allergyType;
  final String? severity;
  final String? note;

  const AllergyEntity({
    this.allergyType,
    this.severity,
    this.note
  });
  
  @override
  List<Object?> get props => [allergyType, severity, note];

  AllergyEntity copyWith({
    AllergyType? allergyType,
    String? severity,
    String? note,
  }) {
    return AllergyEntity(
      allergyType: allergyType ?? this.allergyType,
      severity: severity ?? this.severity,
      note: note ?? this.note,
    );
  }

}
