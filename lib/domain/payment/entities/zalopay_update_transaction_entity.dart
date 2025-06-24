import 'package:health_management/data/payment/models/update_transaction_request.dart';

class ZalopayUpdateTransactionEntity {
  final int? appointmentId;
  final String? transactionId;
  final String? zpTransToken;
  final double? amount;

  ZalopayUpdateTransactionEntity({
    this.appointmentId,
    this.transactionId,
    this.zpTransToken,
    this.amount,
  });

  ZalopayUpdateTransactionEntity copyWith({
    int? appointmentId,
    String? transactionId,
    String? zpTransToken,
    double? amount,
  }) {
    return ZalopayUpdateTransactionEntity(
      appointmentId: appointmentId ?? this.appointmentId,
      transactionId: transactionId ?? this.transactionId,
      zpTransToken: zpTransToken ?? this.zpTransToken,
      amount: amount ?? this.amount,
    );
  }

  UpdateTransactionRequest toUpdateTransactionRequest() {
    return UpdateTransactionRequest(
      appointmentId: appointmentId,
      transactionId: transactionId,
      zpTransToken: zpTransToken,
      amount: amount,
    );
  }
}
