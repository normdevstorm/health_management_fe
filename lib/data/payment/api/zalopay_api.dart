import 'package:dio/dio.dart';
import 'package:health_management/data/common/api_response_model.dart';
import 'package:health_management/data/payment/models/create_order_request.dart';
import 'package:health_management/data/payment/models/create_order_response.dart';
import 'package:retrofit/retrofit.dart';

part 'zalopay_api.g.dart';

@RestApi()
abstract class ZalopayApi {
  factory ZalopayApi(Dio dio, {String baseUrl}) = _ZalopayApi;

  @POST("/payment/zalo/create-order")
  Future<ApiResponse<ZaloPayOrderData>> createOrder(
      @Body() CreateOrderRequest zaloPayRequest);
}
