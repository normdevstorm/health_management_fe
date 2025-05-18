class ZaloPayOrderResponse {
  final int? returnCode;
  final String? returnMessage;
  final int? subReturnCode;
  final String? subReturnMessage;
  final String? zpTransToken;
  final String? orderUrl;
  final String? orderToken;
  final String? qrCode;
  final String? cashierOrderUrl;

  ZaloPayOrderResponse({
    this.returnCode,
    this.returnMessage,
    this.subReturnCode,
    this.subReturnMessage,
    this.zpTransToken,
    this.orderUrl,
    this.orderToken,
    this.qrCode,
    this.cashierOrderUrl,
  });

  ZaloPayOrderResponse copyWith({
    int? returnCode,
    String? returnMessage,
    int? subReturnCode,
    String? subReturnMessage,
    String? zpTransToken,
    String? orderUrl,
    String? orderToken,
    String? qrCode,
    String? cashierOrderUrl,
  }) =>
      ZaloPayOrderResponse(
        returnCode: returnCode ?? this.returnCode,
        returnMessage: returnMessage ?? this.returnMessage,
        subReturnCode: subReturnCode ?? this.subReturnCode,
        subReturnMessage: subReturnMessage ?? this.subReturnMessage,
        zpTransToken: zpTransToken ?? this.zpTransToken,
        orderUrl: orderUrl ?? this.orderUrl,
        orderToken: orderToken ?? this.orderToken,
        qrCode: qrCode ?? this.qrCode,
        cashierOrderUrl: cashierOrderUrl ?? this.cashierOrderUrl,
      );

  factory ZaloPayOrderResponse.fromJson(Map<String, dynamic> json) =>
      ZaloPayOrderResponse(
        returnCode: json["return_code"],
        returnMessage: json["return_message"],
        subReturnCode: json["sub_return_code"],
        subReturnMessage: json["sub_return_message"],
        zpTransToken: json["zp_trans_token"],
        orderUrl: json["order_url"],
        orderToken: json["order_token"],
        qrCode: json["qr_code"],
        cashierOrderUrl: json["cashier_order_url"],
      );

  Map<String, dynamic> toJson() => {
        "return_code": returnCode,
        "return_message": returnMessage,
        "sub_return_code": subReturnCode,
        "sub_return_message": subReturnMessage,
        "zp_trans_token": zpTransToken,
        "order_url": orderUrl,
        "order_token": orderToken,
        "qr_code": qrCode,
        "cashier_order_url": cashierOrderUrl,
      };
}
