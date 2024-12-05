import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/data/prescription/models/request/prescription_ai_analysis_request.dart';

import 'package:health_management/domain/prescription/entities/prescription_side_effect_risk_entity.dart';
import 'package:logger/logger.dart';

import '../../../domain/prescription/repositories/prescription_repository.dart';
import '../api/prescription_api.dart';

class PrescriptionRepositoryImpl implements PrescriptionRepository {
  final PrescriptionApi api;
  final Logger logger;

  PrescriptionRepositoryImpl(this.api, this.logger);

  @override
  Future<List<PrescriptionSideEffectRiskEntity>?> prescriptionAiAnalysis(
      PrescriptionAiAnalysisRequest request) async {
    try {
      return api
          .prescriptionAiAnalysis(request)
          .then((value) => value.risks?.map((e) => e.toEntity()).toList());
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }
}
