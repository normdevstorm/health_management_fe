class ZaloPayOrderRequest {
  final int? appId;
  final String? appUser;
  final int? appTime;
  final int? amount;
  final String? appTransId;
  final String? bankCode;
  final String? embedData;
  final String? item;
  final String? callbackUrl;
  final String? description;
  final String? mac;

  ZaloPayOrderRequest({
    this.appId,
    this.appUser,
    this.appTime,
    this.amount,
    this.appTransId,
    this.bankCode,
    this.embedData,
    this.item,
    this.callbackUrl,
    this.description,
    this.mac,
  });

  ZaloPayOrderRequest copyWith({
    int? appId,
    String? appUser,
    int? appTime,
    int? amount,
    String? appTransId,
    String? bankCode,
    String? embedData,
    String? item,
    String? callbackUrl,
    String? description,
    String? mac,
  }) =>
      ZaloPayOrderRequest(
        appId: appId ?? this.appId,
        appUser: appUser ?? this.appUser,
        appTime: appTime ?? this.appTime,
        amount: amount ?? this.amount,
        appTransId: appTransId ?? this.appTransId,
        bankCode: bankCode ?? this.bankCode,
        embedData: embedData ?? this.embedData,
        item: item ?? this.item,
        callbackUrl: callbackUrl ?? this.callbackUrl,
        description: description ?? this.description,
        mac: mac ?? this.mac,
      );

  factory ZaloPayOrderRequest.fromJson(Map<String, dynamic> json) =>
      ZaloPayOrderRequest(
        appId: json["app_id"],
        appUser: json["app_user"],
        appTime: json["app_time"],
        amount: json["amount"],
        appTransId: json["app_trans_id"],
        bankCode: json["bank_code"],
        embedData: json["embed_data"],
        item: json["item"],
        callbackUrl: json["callback_url"],
        description: json["description"],
        mac: json["mac"],
      );

  Map<String, dynamic> toJson() => {
        "app_id": appId,
        "app_user": appUser,
        "app_time": appTime,
        "amount": amount,
        "app_trans_id": appTransId,
        "bank_code": bankCode,
        "embed_data": embedData,
        "item": item,
        // "callback_url": callbackUrl,
        "description": description,
        "mac": mac,
      };
}
