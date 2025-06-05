import '../../app.dart';

class PaymentUtils {
  static PaymentStatus getPaymentStatusFromString(String status) {
    switch (status) {
      case 'PAYMENT_CANCELLED':
        return PaymentStatus.cancelled;
      case 'PAYMENT_SUCCESS':
        return PaymentStatus.success;
      case 'PAYMENT_FAILED':
      default:
        return PaymentStatus.failed;
    }
  }
}
