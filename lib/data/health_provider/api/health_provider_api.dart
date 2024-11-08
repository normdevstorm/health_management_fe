import 'package:dio/dio.dart';
import 'package:health_management/data/health_provider/models/request/health_provider_request.dart';
import 'package:health_management/data/health_provider/models/response/health_provider_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/api_response_model.dart';

part 'health_provider_api.g.dart';

@RestApi()
abstract class HealthProviderApi {
  factory HealthProviderApi(Dio dio, {String baseUrl}) = _HealthProviderApi;

  @GET("/health-providers/all")
  Future<ApiResponse<List<HealthProviderResponse>>> getAllHealthProviders();

  @POST("/health-providers/create")
  Future<ApiResponse<HealthProviderResponse>> createHealthProvider(@Body() HealthProviderRequest healthProviderCreateRequest);

  @PUT("/health-providers/update")
  Future<ApiResponse<HealthProviderResponse>> updateHealthProvider(@Body() HealthProviderRequest healthProviderUpdateRequest);

  @POST("/health-providers/{providerId}/doctors/{doctorId}")
  Future<ApiResponse<HealthProviderResponse>> addDoctor(
    @Path("providerId") int providerId, 
    @Path("doctorId") int doctorId
  );

  @DELETE("/health-providers/{providerId}/doctors/{doctorId}")
  Future<ApiResponse<HealthProviderResponse>> doctorLeaveHealthProvider(
    @Path("providerId") int providerId, 
    @Path("doctorId") int doctorId
  );

}

