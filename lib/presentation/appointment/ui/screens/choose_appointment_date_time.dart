import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/presentation/appointment/bloc/appointment/appointment_bloc.dart';
import 'package:health_management/presentation/appointment/ui/screens/appointment_home.dart';
import 'package:health_management/presentation/common/tag.dart';

import '../../../../app/route/route_define.dart';

class ChooseAppointmentDateTimeScreen extends StatelessWidget {
  const ChooseAppointmentDateTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppointmentBloc, AppointmentState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current is CreateAppointmentRecordState,
      listener: (context, state) {
        // TODO: implement listener
        if (state.status == BlocStatus.success) {
          context.goNamed(RouteDefine.appointment);
        } else if (state.status == BlocStatus.error) {
          ToastManager.showToast(
              context: context, message: state.errorMessage!);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.verticalSpace,
              Text(
                "Booking Appointment",
                style: TextStyle(
                    color: ColorManager.textBlockColorLight,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold),
              ),
              30.verticalSpace,
              const Text(
                'Select Schedule',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              12.verticalSpace,
              SizedBox(
                height: 70.h,
                child: WeekDaysRowWidget(enableSelection: true,),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Morning',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.w,
                    runSpacing: 10.w,
                    children: const [
                      TagChip(
                        text: '7:00 AM',
                      ),
                      TagChip(
                        text: '8:00 AM',
                        isSelected: true,
                      ),
                      TagChip(
                        text: '9:00 AM',
                      ),
                      TagChip(
                        text: '10:00 AM',
                      ),
                      TagChip(
                        text: '11:00 AM',
                        active: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Afternoon',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.w,
                    runSpacing: 10.w,
                    children: const [
                      TagChip(
                        text: '7:00 AM',
                      ),
                      TagChip(
                        text: '8:00 AM',
                        isSelected: true,
                      ),
                      TagChip(
                        text: '9:00 AM',
                      ),
                      TagChip(
                        text: '10:00 AM',
                      ),
                      TagChip(
                        text: '11:00 AM',
                        active: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeButton(String time) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        overlayColor: Colors.white,
      ),
      child: Text(time),
    );
  }
}

class DayButton extends StatelessWidget {
  final String day;
  final String time;
  final bool selected;

  const DayButton({
    super.key,
    required this.day,
    required this.time,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AppointmentBloc>()
          ..add(CollectDataDatetimeEvent(
              scheduledAt: DateTime.now().copyWith(
                  minute: 0, millisecond: 0, microsecond: 0, second: 0)))
          ..add(const CreateAppointmentRecordEvent());
      },
      child: Container(
          margin: EdgeInsets.only(left: 10.w),
          child: TagChip(
            text: '$day\n$time',
            height: 50.h,
            width: 40.w,
            isSelected: selected,
          )),
    );
  }
}
