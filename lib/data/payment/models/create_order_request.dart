class CreateOrderRequest {
  final double? amount;
  // final Long? appointmentId;
  final int? userId;
  final String? description;
  CreateOrderRequest(
      {this.amount,
      // this.appointmentId,
      this.userId,
      this.description});

  CreateOrderRequest copyWith(
          {double? amount,
          // Long? appointmentId,
          int? userId,
          String? description}) =>
      CreateOrderRequest(
          // appointmentId: appointmentId ?? this.appointmentId,
          amount: amount ?? this.amount,
          userId: userId ?? this.userId,
          description: description ?? this.description);

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      CreateOrderRequest(
        amount: json["amount"],
        // appointmentId: json["appointment_id"],
        userId: json["user_id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        // "appointment_id": appointmentId,
        "user_id": userId,
        "description": description,
      };
}
