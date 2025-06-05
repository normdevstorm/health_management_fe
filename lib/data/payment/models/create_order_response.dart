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
