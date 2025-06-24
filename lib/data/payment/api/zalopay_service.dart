import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:logger/logger.dart';

import '../models/zalopay_payment_response.dart';

class ZalopayService {
  static const MethodChannel _channel =
      MethodChannel('com.example.health_management/zalopay');
  static const MethodChannel _hMacChannel =
      MethodChannel('com.example.health_management/macHelper');

  static Future<ZalopayPaymentResponse?> payOrder(String zpTransToken) async {
    try {
      final String result = await _channel.invokeMethod(
        'payOrder',
        {
          'zp_trans_token': zpTransToken,
        },
      );
      // Parse the JSON string response from native code
      final Map<String, dynamic> jsonResponse = Map<String, dynamic>.from(
          jsonDecode(result) as Map<dynamic, dynamic>);
      ZalopayPaymentResponse paymentResponse =
          ZalopayPaymentResponse.fromJson(jsonResponse);
      return paymentResponse;
    } on PlatformException catch (e) {
      getIt<Logger>().e(e.message);
      throw ApiException.notImplemented(e.code);
    }
  }

  static Future<Map<String, String>> getHMacAndTransId(
      {String? appId,
      String? appUser,
      String? appTime,
      String? amount,
      String? appTransId,
      String? embedData,
      String? items}) async {
    try {
      final Map<Object?, Object?> result =
          await _hMacChannel.invokeMethod('getHMacAndTransId', {
        'app_id': appId,
        'app_user': appUser,
        'app_time': appTime,
        'amount': amount,
        'app_trans_id': appTransId,
        'embed_data': embedData,
        'items': items,
        'bank_code': 'zalopayapp',
        'description': 'Thanh toán đơn hàng'
      });
      print(result);

      String? mac = (result["mac"] as String);
      appTransId = (result["app_trans_id"] as String);

      return Map.of({"mac": mac, "app_trans_id": appTransId});
    } on PlatformException catch (e) {
      getIt<Logger>().e(e.message);
      throw ApiException.notImplemented(e.code);
    }
  }

  static Future<bool> isZaloPayInstalled() async {
    try {
      final bool result = await _channel.invokeMethod('isZaloPayInstalled');
      return result;
    } on PlatformException catch (e) {
      getIt<Logger>().e(e.message);
      throw ApiException.notImplemented(e.code);
    }
  }
}
