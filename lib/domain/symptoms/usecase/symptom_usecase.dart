import 'package:health_management/domain/symptoms/entities/symptoms_entity.dart';
import 'package:health_management/domain/symptoms/repositories/symptom_repository.dart';

class SymptomUseCase {
  final SymptomRepository symptomRepository;

  SymptomUseCase({required this.symptomRepository});

  Future<List<SymptomEntity>> getSymptoms() async {
    return await symptomRepository.getSymptoms();
  }
}
