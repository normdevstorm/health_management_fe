import 'package:dio/dio.dart';
import 'package:health_management/data/appointment/models/response/appointment_record_response.dart';
import 'package:health_management/data/common/api_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'appointment_api.g.dart';

@RestApi()
abstract class AppointmentApi {
  factory AppointmentApi(Dio dio, {String baseUrl}) = _AppointmentApi;
  @GET('/appointment-record/all')
  Future<ApiResponse<List<AppointmentRecordResponse>>> getAllAppointmentRecords();
  // @POST('/appointments/create')
  // Future<ApiResponse<AppointmentRecordEntity>> createAppointmentRecord(@Body() AppointmentRecordEntity appointment);
  // @PUT('/appointments/update')
  // Future<ApiResponse<AppointmentRecordEntity>> updateAppointmentRecord(@Body() AppointmentRecordEntity appointment);
  // @DELETE('/appointments/delete/{id}')
  // Future<ApiResponse<String>> deleteAppointmentRecord(@Path('id') String id);


  
}

