import 'package:dio/dio.dart';
import 'package:health_management/data/appointment/models/request/appointment_record_request.dart';
import 'package:health_management/data/appointment/models/request/update_appointment_record_request.dart';
import 'package:health_management/data/appointment/models/response/appointment_record_response.dart';
import 'package:health_management/data/common/api_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'appointment_api.g.dart';

@RestApi()
abstract class AppointmentApi {
  factory AppointmentApi(Dio dio, {String baseUrl}) = _AppointmentApi;
  @GET('/appointment-record/all')
  Future<ApiResponse<List<AppointmentRecordResponse>>>
      getAllAppointmentRecords();
  @GET('/appointment-record/{id}')
  Future<ApiResponse<AppointmentRecordResponse>>
      getAppointmentRecordById(@Path('id') int appointmentId);
  @POST('/appointment-record/create')
  Future<ApiResponse<AppointmentRecordResponse>> createAppointmentRecord(
      @Body() AppointmentRecordRequest appointment);
  @PUT('/appointment-record/update')
  Future<ApiResponse<AppointmentRecordResponse>> updateAppointmentRecord(
      @Body() UpdateAppointmentRecordRequest appointment);
  @DELETE('/appointment-record/delete/{id}')
  Future<ApiResponse<String>> deleteAppointmentRecord(
      @Path('id') int appointmentId);
  @GET('/appointment-record/user/{id}')
  Future<ApiResponse<List<AppointmentRecordResponse>>>
      getAppointmentRecordByUserId(@Path('id') int userId);
}
