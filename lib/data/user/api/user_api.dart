import 'package:dio/dio.dart';
import 'package:health_management/data/common/api_response_model.dart';
import 'package:health_management/data/doctor/models/response/doctor_response.dart';
import 'package:health_management/data/user/models/response/user_summary_response.dart';
import 'package:retrofit/retrofit.dart';
import '../models/request/update_user_request.dart';
import '../models/response/user_response.dart';
part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET('/users/doctors')
  Future<ApiResponse<List<UserResponse>>> getDoctors();

  @GET('/users/patients')
  Future<ApiResponse<List<UserResponse>>> getPatients();

  @DELETE('/users/delete')
  Future<String> deleteUser(@Query("userId") int userId);

  @GET('/users/summary/{id}')
  Future<ApiResponse<UserSummaryResponse>> getUserSummary(@Path("id") int id);

  @POST('/users/update-user')
  Future<ApiResponse<UserResponse>> updateUser(
      @Body() UpdateUserRequest updateUserRequest,
      @Query("userId") int userId);

  @GET('/users/email')
  Future<ApiResponse<UserSummaryResponse>> getUserByEmail(
      @Query("email") String email);

  @GET('/users/top-rated')
  Future<ApiResponse<List<DoctorResponse>>> getTopRatedDoctors();
}
