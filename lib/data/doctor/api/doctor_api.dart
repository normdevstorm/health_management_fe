import 'package:dio/dio.dart';

import 'package:health_management/data/common/api_response_model.dart';
import 'package:health_management/data/doctor/models/response/doctor_response.dart';
import 'package:health_management/data/user/models/response/user_response.dart';
import 'package:retrofit/retrofit.dart';

part 'doctor_api.g.dart';

@RestApi()
abstract class DoctorApi {
  factory DoctorApi(Dio dio, {String baseUrl}) = _DoctorApi;
  // @GET('/users/doctors')
  // Future<ApiResponse<List<DoctorResponse>>> getAllDoctor();

  @GET('/users/top-rated')
  Future<ApiResponse<List<UserResponse>>> getAllDoctorTopRated();
}
