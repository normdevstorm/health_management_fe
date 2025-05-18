package com.example.health_management

//import androidx.compose.ui.semantics.error

import android.content.Intent
import android.os.Bundle
import com.example.health_management.Constant.AppInfo
import com.example.health_management.Helper.Helpers
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import vn.zalopay.sdk.Environment
import vn.zalopay.sdk.ZaloPayError
import vn.zalopay.sdk.ZaloPaySDK
import vn.zalopay.sdk.listeners.PayOrderListener

class MainActivity: FlutterActivity() {
    private val channelPayOrder = "com.example.health_management/zalopay" // Ensure matches Dart side
    private val macHelperchannel = "com.example.health_management/macHelper" // Example for another channel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Ensure ZaloPaySDK is initialized if needed
        ZaloPaySDK.init(2553, Environment.SANDBOX) // If initialization is required
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelPayOrder)
            .setMethodCallHandler { call, result ->
                if (call.method == "payOrder") {
                    val token = call.argument<String>("zp_trans_token")
                    val applicationId = this@MainActivity.applicationContext.packageName
                    val uriScheme = "${applicationId}://app"


                    if (token == null) {
                        result.error("INVALID_ARGUMENT", "zp_trans_token cannot be null", null)
                        return@setMethodCallHandler
                    }



                    ZaloPaySDK.getInstance().payOrder(this@MainActivity, token, uriScheme, object : PayOrderListener {
                        override fun onPaymentCanceled(zpTransToken: String?, appTransID: String?) {
                            result.success("User Canceled") // Send result back to Flutter
                        }

                        override fun onPaymentError(zaloPayErrorCode: ZaloPayError?, zpTransToken: String?, appTransID: String?) {
                            // Consider sending more specific error information
                            // if (zaloPayErrorCode == ZaloPayError.PAYMENT_APP_NOT_FOUND) {
                            //     result.error("APP_NOT_FOUND", "ZaloPay app not found", null)
                            // } else {
                            //     result.error("PAYMENT_FAILED", "Payment failed: ${zaloPayErrorCode?.name}", null)
                            // }
                            result.success("Payment failed") // Simplified for now
                        }

                        override fun onPaymentSucceeded(transactionId: String, transToken: String, appTransID: String?) {
                            result.success("Payment Success") // Send result back to Flutter
                        }
                    })
                } else {
                    result.notImplemented()
                }
            }

            MethodChannel(flutterEngine.dartExecutor.binaryMessenger,macHelperchannel)
             .setMethodCallHandler { call, result ->
                 // Handle other method calls here
                if(call.method == "getHMacAndTransId") {
                    val appId = call.argument<String>("app_id");
                    val appUser = call.argument<String>("app_user");
                    val appTime = call.argument<String>("app_time");
                    val amount = call.argument<String>("amount");
                    val embedData = call.argument<String>("embed_data");
                    val items = call.argument<String>("items");
                    val bankCode= call.argument<String>("bank_code");
                    val description = call.argument<String>("description");
                    val appTransId = Helpers.getAppTransId();
                    val inputHMac = String.format(
                        "%s|%s|%s|%s|%s|%s|%s",
                        appId,
                        appTransId,
                        appUser,
                        amount,
                        appTime,
                        embedData,
                        items
                    )

                    val mac = Helpers.getMac(AppInfo.MAC_KEY, inputHMac);
                    result.success(mapOf("mac" to mac, "app_trans_id" to  appTransId));
                }
                 else {
                    result.notImplemented();
                }
             }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        ZaloPaySDK.getInstance().onResult(intent)
    }
}
