import '../../../data/payment/models/create_order_response.dart';
import '../entities/zalopay_create_order_entity.dart';
import '../entities/zalopay_update_transaction_entity.dart';
import '../repositories/zalopay_repository.dart';

class ZalopayUsecase {
  final ZalopayRepository _zalopayRepository;
  ZalopayUsecase(this._zalopayRepository);

  Future<ZaloPayOrderData> createOrder(
      ZalopayCreateOrderEntity zalopayCreateOrderEntity) async {
    return await _zalopayRepository.createOrder(zalopayCreateOrderEntity);
  }

  Future<String> updateOrder(
      ZalopayUpdateTransactionEntity zalopayUpdateTransactionEntity) async {
    return await _zalopayRepository.updateOrder(zalopayUpdateTransactionEntity);
  }
}
