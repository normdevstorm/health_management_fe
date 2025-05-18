import 'package:dio/dio.dart';
import 'package:health_management/data/payment/models/zalopay_oder_response.dart';
import 'package:health_management/data/payment/models/zalopay_order_request.dart';
import 'package:retrofit/retrofit.dart';

part 'zalopay_api.g.dart';

@RestApi()
abstract class ZalopayApi {
  factory ZalopayApi(Dio dio, {String baseUrl}) = _ZalopayApi;

  @POST("/create")
  Future<ZaloPayOrderResponse> createOrder(
      @Body() ZaloPayOrderRequest zaloPayRequest);
}
