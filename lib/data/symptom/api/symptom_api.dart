import 'package:dio/dio.dart';
import 'package:health_management/data/symptom/models/recommend_ai_response.dart';
import 'package:health_management/data/symptom/models/symptom_response.dart';
import 'package:retrofit/retrofit.dart';

part 'symptom_api.g.dart';

@RestApi()
abstract class SymptomApi {
  factory SymptomApi(Dio dio, {String baseUrl}) = _SymptomApi;

  @GET('/symptoms/')
  Future<SymptomResponse> getSymptoms();

  @POST('/diagnose/')
  Future<RecommendAiResponse> recommendSymptoms(
    @Body() Map<String, dynamic> body,
  );
}
