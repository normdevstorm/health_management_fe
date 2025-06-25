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
  @GET('/appointments/all')
  Future<ApiResponse<List<AppointmentRecordResponse>>>
      getAllAppointmentRecords();
  @GET('/appointments/{id}')
  Future<ApiResponse<AppointmentRecordResponse>> getAppointmentRecordById(
      @Path('id') int appointmentId);
  @POST('/appointments/create')
  Future<ApiResponse<AppointmentRecordResponse>> createAppointmentRecord(
      @Body() AppointmentRecordRequest appointment);
  @PUT('/appointments/update')
  Future<ApiResponse<AppointmentRecordResponse>> updateAppointmentRecord(
      @Body() UpdateAppointmentRecordRequest appointment);
  @DELETE('/appointments/delete/{id}')
  Future<ApiResponse<String>> deleteAppointmentRecord(
      @Path('id') int appointmentId);
  @POST('/appointments/cancel/{userId}/{appointmentId}')
  Future<ApiResponse<String>> cancelAppointmentRecord(
      @Path('userId') int userId, @Path('appointmentId') int appointmentId);
  @GET('/appointments/user/{id}')
  Future<ApiResponse<List<AppointmentRecordResponse>>>
      getAppointmentRecordByUserId(@Path('id') int userId);
  @GET('/appointments/doctor/{id}')
  Future<ApiResponse<List<AppointmentRecordResponse>>>
      getAppointmentRecordByDoctorId(@Path('id') int doctorId);
}
