import 'package:health_management/app/app.dart';

import '../../../app/utils/extensions/payment_utils.dart';

class ZalopayPaymentResponse {
  final PaymentStatus? status;
  final String? zpTransToken;
  final String? transactionId;

  ZalopayPaymentResponse({
    this.status,
    this.zpTransToken,
    this.transactionId,
  });

  ZalopayPaymentResponse copyWith({
    PaymentStatus? status,
    String? zpTransToken,
    String? transactionId,
  }) {
    return ZalopayPaymentResponse(
      status: status ?? this.status,
      zpTransToken: zpTransToken ?? this.zpTransToken,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  factory ZalopayPaymentResponse.fromJson(Map<String, dynamic> json) {
    return ZalopayPaymentResponse(
      status: PaymentUtils.getPaymentStatusFromString(json['status'])
          as PaymentStatus?,
      zpTransToken: json['zp_trans_token'] as String?,
      transactionId: json['transaction_id'] as String?,
    );
  }
}
