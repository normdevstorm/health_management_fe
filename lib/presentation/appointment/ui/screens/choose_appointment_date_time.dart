import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/presentation/appointment/bloc/appointment/appointment_bloc.dart';
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
            Text(
              "Step 3/5",
              style: TextStyle(
                  color: ColorManager.highlightColorLight, fontSize: 13.sp),
            ),
            30.verticalSpace,
            Text(
              'Select Schedule',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            12.verticalSpace,
            SizedBox(
              height: 70.h,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  DayButton(day: 'Mon', time: '7'),
                  DayButton(day: 'Tue', time: '8'),
                  DayButton(day: 'Wed', time: '10'),
                  DayButton(day: 'Thu', time: '11', selected: true),
                  DayButton(day: 'Fri', time: '12'),
                  DayButton(day: 'Sat', time: '13'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Morning',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 10.w,
                  runSpacing: 10.w,
                  children: [
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
                SizedBox(height: 20),
                Text(
                  'Afternoon',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 10.w,
                  runSpacing: 10.w,
                  children: [
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
                SizedBox(height: 20),
              ],
            ),
            Divider(),
          ],
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
          ..add(CreateAppointmentRecordChooseDatetimeEvent(
              scheduledAt: DateTime.now()))
          ..add(CreateAppointmentRecordEvent());
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
