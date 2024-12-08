import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/data/prescription/models/request/prescription_ai_analysis_request.dart';
import 'package:health_management/domain/prescription/entities/medication.dart';
import 'package:health_management/domain/prescription/entities/prescription_side_effect_risk_entity.dart';
import 'package:logger/logger.dart';
import '../../../domain/prescription/repositories/prescription_repository.dart';
import '../api/medication_api.dart';
import '../api/prescription_api.dart';

class PrescriptionRepositoryImpl implements PrescriptionRepository {
  final PrescriptionApi prescriptionApi;
  final MedicationApi medicationApi;
  final Logger logger;

  PrescriptionRepositoryImpl(this.prescriptionApi,this.medicationApi, this.logger);

  @override
  Future<List<PrescriptionSideEffectRiskEntity>?> prescriptionAiAnalysis(
      PrescriptionAiAnalysisRequest request) async {
    try {
      return prescriptionApi
          .prescriptionAiAnalysis(request)
          .then((value) => value.risks?.map((e) => e.toEntity()).toList());
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<List<Medication>> getAllMedications() async {
    try {
      final response = await medicationApi.getAllMedications();
      return response.data ?? [];
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }
}
