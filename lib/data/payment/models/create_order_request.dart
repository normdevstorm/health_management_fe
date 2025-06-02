class CreateOrderRequest {
  final double? amount;
  final int? userId;
  final String? description;
  CreateOrderRequest({this.amount, this.userId, this.description});

  CreateOrderRequest copyWith(
          {double? amount, int? userId, String? description}) =>
      CreateOrderRequest(
          amount: amount ?? this.amount,
          userId: userId ?? this.userId,
          description: description ?? this.description);

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      CreateOrderRequest(
        amount: json["amount"],
        userId: json["user_id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "user_id": userId,
        "description": description,
      };
}
