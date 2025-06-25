import 'package:health_management/data/symptom/models/recommend_ai_response.dart';

abstract class SymptomRepository {
  Future<List<String>> getSymptoms();
  Future<RecommendAiResponse> diagnose(List<String> symptoms);
}
