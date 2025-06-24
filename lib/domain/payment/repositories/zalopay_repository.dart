import 'package:health_management/domain/payment/entities/zalopay_create_order_entity.dart';
import 'package:health_management/domain/payment/entities/zalopay_update_transaction_entity.dart';
import '../../../data/payment/models/create_order_response.dart';

abstract class ZalopayRepository {
  Future<ZaloPayOrderData> createOrder(
      ZalopayCreateOrderEntity zalopayCreateOrderEntity);
  Future<String> updateOrder(
      ZalopayUpdateTransactionEntity zalopayUpdateTransactionEntity);
}
