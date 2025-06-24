import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/data/common/api_response_model.dart';
import 'package:health_management/data/payment/api/zalopay_api.dart';
import 'package:health_management/data/payment/models/create_order_request.dart';
import 'package:health_management/data/payment/models/create_order_response.dart';
import 'package:health_management/domain/payment/entities/zalopay_create_order_entity.dart';
import 'package:health_management/domain/payment/entities/zalopay_update_transaction_entity.dart';
import 'package:health_management/domain/payment/repositories/zalopay_repository.dart';
import 'package:logger/logger.dart';

class ZalopayRepositoryImpl implements ZalopayRepository {
  final ZalopayApi zalopayApi;
  final Logger logger;

  ZalopayRepositoryImpl(this.zalopayApi, this.logger);

  @override
  Future<ZaloPayOrderData> createOrder(
      ZalopayCreateOrderEntity zalopayCreateOrderEntity) async {
    try {
      CreateOrderRequest zaloPayOrderRequest =
          zalopayCreateOrderEntity.toCreateOrderRequest();
      ApiResponse<ZaloPayOrderData> result =
          await zalopayApi.createOrder(zaloPayOrderRequest);
      return result.data as ZaloPayOrderData;
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<String> updateOrder(
      ZalopayUpdateTransactionEntity zalopayUpdateTransactionEntity) async {
    try {
      ApiResponse<String> result = await zalopayApi.updateOrder(
          zalopayUpdateTransactionEntity.toUpdateTransactionRequest());
      return result.data as String;
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }
}
