import 'package:dio/dio.dart';
import 'package:health_management/data/common/api_response_model.dart';
import 'package:health_management/data/doctor_schedule/models/response/doctor_schedule_response.dart';
import 'package:retrofit/retrofit.dart';

part 'doctor_schedule_api.g.dart';

@RestApi()
abstract class DoctorScheduleApi {
  factory DoctorScheduleApi(Dio dio, {String baseUrl}) = _DoctorScheduleApi;

  @GET('/schedule/doctor/{doctorId}')
  Future<ApiResponse<List<DoctorScheduleResponse>>> getDoctorSchedule(@Path('doctorId') int doctorId);
}

