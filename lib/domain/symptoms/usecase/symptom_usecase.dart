import 'package:health_management/data/symptom/models/recommend_ai_response.dart';
import 'package:health_management/domain/symptoms/repositories/symptom_repository.dart';

class SymptomUseCase {
  final SymptomRepository symptomRepository;

  SymptomUseCase({required this.symptomRepository});

  Future<List<String>> getSymptoms() async {
    return await symptomRepository.getSymptoms();
  }

  Future<RecommendAiResponse> diagnose(List<String> symptoms) async {
    return await symptomRepository.diagnose(symptoms);
  }
}
