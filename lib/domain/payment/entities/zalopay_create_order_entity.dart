import 'package:health_management/data/payment/models/create_order_request.dart';

class ZalopayCreateOrderEntity {
  final int? userId;
  final int? amount;
  final String? description;

  ZalopayCreateOrderEntity({
    this.userId,
    this.amount,
    this.description,
  });

  factory ZalopayCreateOrderEntity.fromJson(Map<String, dynamic> json) =>
      ZalopayCreateOrderEntity(
        userId: json["user_id"] as int?,
        amount: json["amount"] as int?,
        description: json["description"] as String?,
      );

  CreateOrderRequest toCreateOrderRequest() {
    return CreateOrderRequest(
      userId: userId,
      amount: amount?.toDouble(),
      description: description,
    );
  }
}
