import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/utils/date_converter.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/presentation/appointment/ui/widgets/timeline_schedule.dart';
import '../../../../app/managers/toast_manager.dart';
import '../../../common/shimmer_loading.dart';
import '../../bloc/appointment_bloc.dart';
import '../widgets/shadow_edge.dart';

class AppointmentHome extends StatelessWidget {
  AppointmentHome({super.key});

  final shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: BlocConsumer<AppointmentBloc, AppointmentState>(
            listener: (context, state) {
              if (state.status == BlocStatus.error) {
                ToastManager.showToast(
                    context: context,
                    message: state.errorMessage ?? 'An error occurred');
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     showCloseIcon: true,
                //     duration: Duration(seconds: 10),
                //     elevation: 100.h,
                //     content: Text(state.errorMessage ?? 'An error occurred'),
                //     backgroundColor: Colors.red,
                //   ),
                // );
              }
            },
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              List<AppointmentRecordEntity> appointmentRecords = [];
              bool isLoading = true;
              if (state.status == BlocStatus.success) {
                isLoading = false;
                appointmentRecords =
                    state.data as List<AppointmentRecordEntity>;
              }
              return Shimmer(
                linearGradient: shimmerGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        DateFormat(DateFormat.YEAR_MONTH_DAY)
                            .format(DateTime.now()),
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Today',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          AddButtonWidget()
                        ]),
                    const SizedBox(height: 16),
                    WeekDaysRowWidget(),
                    ShadowEdgeWidget(),
                    ShimmerLoading(
                        isLoading: isLoading,
                        child:
                            SizedBox(height: 200.r, child: TimelineSchedule())),
                    ShadowEdgeWidget(),
                    ShimmerLoading(
                      isLoading: isLoading,
                      child: ListAppointmentRecordWidget(
                          appointmentRecords: isLoading
                              ? List.generate(
                                  3,
                                  (index) => AppointmentRecordEntity(),
                                )
                              : appointmentRecords),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ListAppointmentRecordWidget extends StatelessWidget {
  const ListAppointmentRecordWidget({
    super.key,
    required this.appointmentRecords,
  });

  final List<AppointmentRecordEntity> appointmentRecords;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(
        appointmentRecords.length,
        (index) => Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: AppointmentCard(
            doctorType:
                appointmentRecords[index].doctor?.doctorProfile?.specialization,
            doctorName: appointmentRecords[index].doctor?.firstName,
            time: appointmentRecords[index].scheduledAt != null
                ? DateConverter.convertToYMD(
                    appointmentRecords[index].scheduledAt!,
                  )
                : null,
            isCompleted:
                appointmentRecords[index].status == AppointmentStatus.completed,
          ),
        ),
      ),
    );
  }
}

class WeekDaysRowWidget extends StatelessWidget {
  final int day = DateTime.now().weekday;
  final DateTime date = DateTime.now();
  WeekDaysRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(7, (index) {
        return Container(
          constraints: BoxConstraints.tight(Size(45.w, 70.h)),
          padding: EdgeInsets.only(top: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ColorManager.buttonBorderColorLight,
            ),
            color: index == (day - 1)
                ? ColorManager.buttonEnabledColorLight
                : ColorManager.buttonDisbledColorLight,
            boxShadow: [
              BoxShadow(
                color: ColorManager.buttonShadowColorLight,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                style: StyleManager.buttonText.copyWith(
                  color: index == (day - 1)
                      ? null
                      : StyleManager.buttonDisabledTextColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${date.subtract(Duration(days: day - 1 - index)).day}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: index == (day - 1) ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(ColorManager.buttonEnabledColorLight),
            padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(horizontal: 16, vertical: 8))),
        icon: Icon(
          Icons.add,
          size: 30.r,
          color: ColorManager.iconButtonColorLight,
        ),
        onPressed: () {},
        label: Text(
          "Add",
          style: StyleManager.buttonText,
        ));
  }
}

class AppointmentCard extends StatefulWidget {
  final String? doctorType;
  final String? doctorName;
  final String? time;
  final bool isCompleted;

  const AppointmentCard({
    super.key,
    this.doctorType,
    this.doctorName,
    this.time,
    this.isCompleted = false,
  });

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.buttonEnabledColorLight,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  //todo: to localize this text later on
                  widget.doctorName ?? "Loading...",
                  style: StyleManager.buttonText,
                ),
                const SizedBox(height: 8),
                Text(widget.doctorType ?? "Loading...",
                    style: StyleManager.buttonText),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < 4 ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.time ?? "Loading...",
                  style: StyleManager.buttonText,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Color(0xFFEFE8E9)),
                        const SizedBox(width: 8),
                        Text(
                          'Apr 08,2022',
                          style: const TextStyle(
                              fontSize: 16, color: Color(0xFFEFE8E9)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Color(0xFFEFE8E9)),
                        const SizedBox(width: 8),
                        Text(
                          widget.time ?? "Loading...",
                          style: const TextStyle(
                              fontSize: 16, color: Color(0xFFEFE8E9)),
                        ),
                      ],
                    ),
                  ],
                )
              ]),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    'assets/images/placeholder.png',
                    width: 100.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          if (!widget.isCompleted) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Reschedule'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class ScheduleTimeline extends StatefulWidget {
  const ScheduleTimeline({super.key});

  @override
  State<ScheduleTimeline> createState() => _ScheduleTimelineState();
}

class _ScheduleTimelineState extends State<ScheduleTimeline> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Time line
                    Timeline(
                      scrollController: _scrollController,
                      items: [
                        TimelineItem(
                          time: '09:00',
                          content: Container(
                            height: 40,
                            color: Colors.blue,
                          ),
                        ),
                        TimelineItem(
                          time: '10:00',
                          content: AppointmentCard(
                            doctorType: 'Cardiologist',
                            doctorName: 'Dan Johnson',
                            time: '10:00-11:00',
                            isCompleted: true,
                          ),
                        ),
                        TimelineItem(
                          time: '11:00',
                          content: Container(
                            height: 40,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class TimelineItem extends StatelessWidget {
  const TimelineItem({
    super.key,
    required this.time,
    required this.content,
  });

  final String time;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(time),
        const SizedBox(width: 16),
        content,
      ],
    );
  }
}

class Timeline extends StatelessWidget {
  const Timeline({
    super.key,
    required this.scrollController,
    required this.items,
  });

  final ScrollController? scrollController;
  final List<TimelineItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return items[index];
      },
    );
  }
}
