import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/data/payment/api/zalopay_api.dart';
import 'package:health_management/data/payment/api/zalopay_service.dart';
import 'package:health_management/data/payment/models/create_order_request.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/presentation/appointment/bloc/appointment/appointment_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class PreviewPaymentScreen extends StatefulWidget {
  const PreviewPaymentScreen({super.key});

  @override
  _PreviewPaymentScreenState createState() => _PreviewPaymentScreenState();
}

class _PreviewPaymentScreenState extends State<PreviewPaymentScreen> {
  int _retryCount = 0;
  static const int _maxRetries = 3;
  Future<void> _proceedToPayment(BuildContext context) async {
    if (_retryCount >= _maxRetries) {
      ToastManager.showToast(
        context: context,
        message:
            'Maximum payment retries reached. Please try again later.'.tr(),
      );
      return;
    }

    try {
      // Fetch user ID from SharedPreferenceManager
      final user = await SharedPreferenceManager.getUser();
      final int userId = user?.id ?? 123;

      final request = CreateOrderRequest(
        amount: 200000,
        userId: userId,
        description: 'Deposit for appointment',
      );

      // Call ZalopayApi to create order
      final response = await getIt<ZalopayApi>().createOrder(request);
      getIt<Logger>().i(
          'ZaloPay API Response: ${response.data?.zpTransToken ?? 'No token'}');

      final zpTransToken = response.data?.zpTransToken;

      if (zpTransToken == null) {
        ToastManager.showToast(
          context: context,
          message: 'Failed to retrieve payment token'.tr(),
        );
        return;
      }

      // Call ZalopayService to process payment
      final PaymentStatus result =
          await ZalopayService.payOrder(zpTransToken) as PaymentStatus;
      getIt<Logger>().i('ZalopayService Result: $result');

      if (result == PaymentStatus.success) {
        // Trigger appointment creation
        context
            .read<AppointmentBloc>()
            .add(const CreateAppointmentRecordEvent());
      } else if (result == PaymentStatus.failed) {
        setState(() {
          _retryCount++;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Payment Failed'.tr()),
            content: Text(
                'Payment failed, please try again. Attempts remaining: ${3 - _retryCount}'
                    .tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'.tr()),
              ),
            ],
          ),
        );
      } else if (result == PaymentStatus.cancelled) {
        // Navigate to AppointmentHome without creating appointment
        context.goNamed(RouteDefine.appointment);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Payment Canceled'.tr()),
            content: Text('You canceled the payment process.'.tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'.tr()),
              ),
            ],
          ),
        );
      } else {
        ToastManager.showToast(
          context: context,
          message: 'Unknown payment result: $result'.tr(),
        );
      }
    } catch (e) {
      getIt<Logger>().e('Payment Error: $e');
      ToastManager.showToast(
        context: context,
        message: 'An error occurred: $e'.tr(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mock data for invoice
    const String invoiceId = 'INV-001';
    const double depositAmount = 200000;
    const String paymentMethod = 'ZaloPay';

    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Payment'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AppointmentBloc, AppointmentState>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current is CreateAppointmentRecordState,
            listener: (context, state) {
              if (state.status == BlocStatus.loading) {
                showDialog(
                  barrierDismissible: false,
                  barrierColor: Colors.white.withOpacity(0.3),
                  context: context,
                  builder: (context) => Center(
                    child: SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: CircularProgressIndicator(
                        color: ColorManager.primaryColorLight,
                        strokeWidth: 4.w,
                      ),
                    ),
                  ),
                );
              } else if (state.status == BlocStatus.success) {
                // Close loading dialog
                Navigator.of(context, rootNavigator: true).pop();

                // Navigate to AppointmentHome
                context.goNamed(RouteDefine.appointment);

                // Show success dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Payment Success'.tr()),
                    content: Text('Your deposit payment was successful.'.tr()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'.tr()),
                      ),
                    ],
                  ),
                );
              } else if (state.status == BlocStatus.error) {
                // Close loading dialog
                Navigator.of(context, rootNavigator: true).pop();

                ToastManager.showToast(
                  context: context,
                  message:
                      state.errorMessage ?? 'Failed to create appointment'.tr(),
                );
              }
            },
            buildWhen: (previous, current) =>
                current is CreateAppointmentRecordState,
            builder: (context, state) {
              final appointment = state.data as AppointmentRecordEntity;
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice Details'.tr(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.textBlockColorLight,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow('Invoice ID'.tr(), invoiceId),
                            SizedBox(height: 8.h),
                            _buildInfoRow(
                              'Deposit Amount'.tr(),
                              NumberFormat.currency(
                                      locale: 'vi_VN', symbol: '₫')
                                  .format(depositAmount),
                            ),
                            SizedBox(height: 8.h),
                            _buildInfoRow('Payment Method'.tr(), 'ZaloPay'),
                            SizedBox(height: 8.h),
                            _buildInfoRow(
                                'Invoice Note'.tr(), 'Deposit for invoice'),
                            SizedBox(height: 8.h),
                            _buildInfoRow(
                                'Doctor'.tr(),
                                appointment.doctor?.firstName != null
                                    ? '${appointment.doctor!.firstName} ${appointment.doctor!.lastName ?? ""}'
                                    : 'Unknown Doctor'),
                            SizedBox(height: 8.h),
                            _buildInfoRow(
                                'Health Provider'.tr(),
                                appointment.healthProvider?.name ??
                                    'Unknown Provider'),
                            SizedBox(height: 8.h),
                            _buildInfoRow('Note for doctor'.tr(),
                                appointment.note ?? 'Unknown Note for doctor'),
                            SizedBox(height: 8.h),
                            _buildInfoRow(
                              'Date time Scheduled'.tr(),
                              appointment.scheduledAt
                                      .toString()
                                      .split('.')
                                      .first ??
                                  '00:00:00',
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _retryCount >= _maxRetries
                            ? null
                            : () => _proceedToPayment(context),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          backgroundColor: _retryCount >= _maxRetries
                              ? Colors.grey
                              : ColorManager.buttonEnabledColorLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Proceed to Payment'.tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
