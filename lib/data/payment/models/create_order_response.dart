class CreateOrderResponse {
  final int? code;
  final String? message;
  final ZaloPayOrderData? data;

  CreateOrderResponse({
    this.code,
    this.message,
    this.data,
  });

  CreateOrderResponse copyWith({
    int? code,
    String? message,
    ZaloPayOrderData? data,
  }) =>
      CreateOrderResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      CreateOrderResponse(
        code: json["code"],
        message: json["message"],
        data: json["data"] != null
            ? ZaloPayOrderData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class ZaloPayOrderData {
  final String? zpTransToken;

  ZaloPayOrderData({
    this.zpTransToken,
  });

  factory ZaloPayOrderData.fromJson(Map<String, dynamic> json) =>
      ZaloPayOrderData(
        zpTransToken: json["zp_trans_token"],
      );

  Map<String, dynamic> toJson() => {
        "zp_trans_token": zpTransToken,
      };
}
