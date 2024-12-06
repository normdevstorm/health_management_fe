import 'package:dio/dio.dart';
import 'package:health_management/data/prescription/models/response/prescription_ai_analysis_response.dart';
import 'package:retrofit/retrofit.dart';

import '../models/request/prescription_ai_analysis_request.dart';

part 'prescription_api.g.dart';

@RestApi()
abstract class PrescriptionApi {
  factory PrescriptionApi(Dio dio, {String baseUrl}) = _PrescriptionApi;

  @POST("")
  Future<PrescriptionAiAnalysisResponse> prescriptionAiAnalysis(@Body() PrescriptionAiAnalysisRequest request);
}

