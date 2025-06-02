import 'package:dio/dio.dart';
import 'package:health_management/data/payment/models/create_order_request.dart';
import 'package:health_management/data/payment/models/create_order_response.dart';
import 'package:health_management/data/payment/models/zalopay_oder_response.dart';
import 'package:health_management/data/payment/models/zalopay_order_request.dart';
import 'package:retrofit/retrofit.dart';

part 'zalopay_api.g.dart';

@RestApi()
abstract class ZalopayApi {
  factory ZalopayApi(Dio dio, {String baseUrl}) = _ZalopayApi;

  @POST("/payment/zalo/create-order")
  Future<CreateOrderResponse> createOrder(
      @Body() CreateOrderRequest zaloPayRequest);
}
