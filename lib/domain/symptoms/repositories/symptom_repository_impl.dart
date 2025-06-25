import 'package:health_management/data/symptom/api/symptom_api.dart';
import 'package:health_management/domain/symptoms/entities/symptoms_entity.dart';

import 'package:health_management/domain/symptoms/repositories/symptom_repository.dart';

class SymptomRepositoryImpl implements SymptomRepository {
  final SymptomApi symptomApi;

  SymptomRepositoryImpl({required this.symptomApi});

  @override
  Future<List<SymptomEntity>> getSymptoms() async {
    final response = await symptomApi.getSymptoms();
    if (response.data != null) {
      return response.data!.asMap().entries.map((entry) {
        return SymptomEntity.fromJson(entry.value, entry.key + 1);
      }).toList();
    } else {
      throw Exception('No symptoms data received');
    }
  }
}
