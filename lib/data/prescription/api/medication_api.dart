import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../domain/prescription/entities/medication.dart';
import '../../common/api_response_model.dart';
part 'medication_api.g.dart';

@RestApi()
abstract class MedicationApi {
  factory MedicationApi(Dio dio, {String baseUrl}) = _MedicationApi;

  @GET("/appointment-record/medication/all")
  Future<ApiResponse<List<Medication>>> getAllMedications();
}