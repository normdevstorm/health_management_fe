import 'package:health_management/domain/symptoms/entities/symptoms_entity.dart';

abstract class SymptomRepository {
  Future<List<SymptomEntity>> getSymptoms();
}
