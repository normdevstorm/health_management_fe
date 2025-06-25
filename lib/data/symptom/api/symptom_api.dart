import 'package:dio/dio.dart';
import 'package:health_management/data/common/api_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'symptom_api.g.dart';

@RestApi()
abstract class SymptomApi {
  factory SymptomApi(Dio dio) = _SymptomApi;

  @GET('http://127.0.0.1:8000/api/symptoms/')
  Future<ApiResponse<List<String>>> getSymptoms();
}
