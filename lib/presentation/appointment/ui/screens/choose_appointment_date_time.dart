import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/domain/doctor_schedule/entities/doctor_schedule_entity.dart';
import 'package:health_management/domain/doctor_schedule/entities/shift_time_entity.dart';
import 'package:health_management/presentation/appointment/bloc/appointment/appointment_bloc.dart';
import 'package:health_management/presentation/appointment/bloc/doctor_schedule/doctor_schedule_bloc.dart';
import 'package:health_management/presentation/common/tag.dart';

import '../../../../app/route/route_define.dart';

class ChooseAppointmentDateTimeScreen extends StatefulWidget {
  final int doctorId;
  const ChooseAppointmentDateTimeScreen({required this.doctorId, super.key});

  @override
  State<ChooseAppointmentDateTimeScreen> createState() =>
      _ChooseAppointmentDateTimeScreenState();
}

class _ChooseAppointmentDateTimeScreenState
    extends State<ChooseAppointmentDateTimeScreen> {
  final ValueNotifier<int?> selectedTimeNotifier = ValueNotifier(null);
  final ValueNotifier<DateTime> selectedDateNotifier = ValueNotifier(
      DateTime.now().copyWith(
          hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0));
  final TextEditingController dateEditingController = TextEditingController();
  final TextEditingController noteEditingController = TextEditingController();
  List<ShiftTimeEntity> shifts = [];

  @override
  void initState() {
    super.initState();
    context
        .read<DoctorScheduleBloc>()
        .add(GetDoctorScheduleEvent(doctorId: widget.doctorId));
  }

  //todo: place this list in constant manager
  final List<Map<String, String>> times = [
    {'7:00 AM': 'Morning'},
    {'8:00 AM': 'Morning'},
    {'9:00 AM': 'Morning'},
    {'10:00 AM': 'Morning'},
    {'11:00 AM': 'Morning'},
    {'1:00 PM': 'Afternoon'},
    {'2:00 PM': 'Afternoon'},
    {'3:00 PM': 'Afternoon'},
    {'4:00 PM': 'Afternoon'},
    {'5:00 PM': 'Afternoon'},
  ];

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
      child: BlocConsumer<DoctorScheduleBloc, DoctorScheduleState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == BlocStatus.error) {
              ToastManager.showToast(
                  context: context, message: state.errorMessage!);
            }
          },
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            if (state.status == BlocStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == BlocStatus.error) {
              return Center(child: Text(state.errorMessage!));
            }

            return ValueListenableBuilder(
                valueListenable: selectedDateNotifier,
                builder: (context, value, child) {
                  shifts = times
                      .map((e) => ShiftTimeEntity(
                            name: e.keys.first,
                            partOfDay: e.values.first,
                            startTime:
                                (int.tryParse(e.keys.first.split(':').first) ??
                                        0) +
                                    (e.values.first == 'Morning' ? 0 : 12),
                          ))
                      .toList();
                  // compare the date
                  List<DoctorScheduleEntity> doctorSchedules = state.data ?? [];
                  for (var element in doctorSchedules) {
                    if (element.startTime
                            ?.copyWith(hour: 0, minute: 0, second: 0) ==
                        selectedDateNotifier.value) {
                      for (var shift in shifts) {
                        if (element.startTime?.hour == shift.startTime &&
                            element.currentPatientCount == 2) {
                          shift.available = false;
                        }
                      }
                    }
                  }

                  dateEditingController.text = selectedDateNotifier.value
                      .toLocal()
                      .toString()
                      .split(' ')[0];
                  return Padding(
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
                            'Select Date',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          12.verticalSpace,
                          TextFormField(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                                barrierColor: Colors.black.withOpacity(0.7),
                              );
                              if (pickedDate != null) {
                                selectedDateNotifier.value =
                                    pickedDate.toLocal();
                                dateEditingController.text = pickedDate
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0];
                              }
                            },
                            controller: dateEditingController,
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blue.shade100,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                                borderSide: BorderSide(
                                  color: ColorManager.primaryColorLight,
                                  width: 1.w,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                                borderSide: BorderSide(
                                  color: ColorManager.buttonBorderColorLight,
                                  width: 1.w,
                                ),
                              ),
                              hintText: "YYYY-MM-DD",
                              suffixIcon: const IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: null,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 20),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     const Text(
                          //       'Morning',
                          //       style: TextStyle(
                          //           fontSize: 15, fontWeight: FontWeight.bold),
                          //     ),
                          //     const SizedBox(height: 10),
                          //     ChooseShiftTimeWidget(
                          //       selectedTimeNotifier: selectedTimeNotifier,
                          //       shifts: shifts,
                          //       partOfDay: 'Morning',
                          //     ),
                          //     const SizedBox(height: 20),
                          //     const Text(
                          //       'Afternoon',
                          //       style: TextStyle(
                          //           fontSize: 16, fontWeight: FontWeight.bold),
                          //     ),
                          //     const SizedBox(height: 10),
                          //     ChooseShiftTimeWidget(
                          //       selectedTimeNotifier: selectedTimeNotifier,
                          //       shifts: shifts,
                          //       partOfDay: 'Afternoon',
                          //     ),
                          //     const SizedBox(height: 20),
                          //   ],
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Morning',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              ChooseShiftTimeWidget(
                                selectedTimeNotifier: selectedTimeNotifier,
                                shifts: shifts,
                                partOfDay: 'Morning',
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Afternoon',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              ChooseShiftTimeWidget(
                                selectedTimeNotifier: selectedTimeNotifier,
                                shifts: shifts,
                                partOfDay: 'Afternoon',
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                          const Divider(),
                          const Text(
                            'Notes for Doctor',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          12.verticalSpace,
                          TextFormField(
                            controller: noteEditingController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Write your notes here...',
                              contentPadding: EdgeInsets.all(15.w),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                                borderSide: BorderSide(
                                  color: ColorManager.buttonBorderColorLight,
                                  width: 2.w,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                                borderSide: BorderSide(
                                  color: ColorManager.buttonEnabledColorLight,
                                  width: 2.w,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                                borderSide: BorderSide(
                                  color: Colors
                                      .blue, // Change the color to green when focused
                                  width: 2.w,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle the save action
                                context.read<AppointmentBloc>()
                                  ..add(CollectDataDatetimeAndNoteEvent(
                                    scheduledAt: selectedDateNotifier.value
                                        .copyWith(
                                            hour: selectedTimeNotifier.value),
                                    note: noteEditingController.text,
                                  ))
                                  ..add(const CreateAppointmentRecordEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager
                                    .buttonEnabledColorLight, // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.r), // Rounded corners
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50.w, vertical: 15.h),
                              ),
                              child: Text(
                                'Save Appointment',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
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

class ChooseShiftTimeWidget extends StatelessWidget {
  const ChooseShiftTimeWidget({
    super.key,
    required this.selectedTimeNotifier,
    required this.shifts,
    required this.partOfDay,
  });

  final ValueNotifier<int?> selectedTimeNotifier;
  final List<ShiftTimeEntity> shifts;
  final String partOfDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: ColorManager.buttonEnabledColorLight,
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(15.w),
      child: ValueListenableBuilder(
        valueListenable: selectedTimeNotifier,
        builder: (context, value, child) => Wrap(
          alignment: WrapAlignment.spaceAround,
          direction: Axis.horizontal,
          spacing: 20.w,
          runSpacing: 10.w,
          children: List.from(shifts
              .where((element) => element.partOfDay == partOfDay)
              .map((e) => TagChip(
                    text: e.name,
                    active: e.available,
                    isSelected: value == e.startTime,
                    onTap: () {
                      if (!e.available) {
                        return;
                      }
                      selectedTimeNotifier.value = e.startTime;
                    },
                  ))),
        ),
      ),
    );
  }
}
