import 'package:health_management/data/symptom/api/symptom_api.dart';
import 'package:health_management/data/symptom/models/recommend_ai_response.dart';

import 'package:health_management/domain/symptoms/repositories/symptom_repository.dart';

class SymptomRepositoryImpl implements SymptomRepository {
  final SymptomApi symptomApi;

  SymptomRepositoryImpl({required this.symptomApi});

  @override
  Future<List<String>> getSymptoms() async {
    final response = await symptomApi.getSymptoms();
    return response.symptoms.toList();
  }

  @override
  Future<RecommendAiResponse> diagnose(List<String> symptoms) {
    final body = {'symptoms': symptoms};
    return symptomApi.recommendSymptoms(body);
  }
}
