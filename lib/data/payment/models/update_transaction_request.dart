class UpdateTransactionRequest {
  final int? appointmentId;
  final String? transactionId;
  final String? zpTransToken;
  final double? amount;

  UpdateTransactionRequest({
    this.appointmentId,
    this.transactionId,
    this.zpTransToken,
    this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'appointment_id': appointmentId,
      'transaction_id': transactionId,
      'zp_trans_token': zpTransToken,
      'amount': amount,
    };
  }
}
