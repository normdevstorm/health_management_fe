import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/utils/date_converter.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/presentation/appointment/ui/widgets/timeline_schedule.dart';
import '../../../../app/managers/toast_manager.dart';
import '../../../../app/route/route_define.dart';
import '../../../common/shimmer_loading.dart';
import '../../bloc/appointment/appointment_bloc.dart';
import '../widgets/shadow_edge.dart';

class AppointmentHome extends StatefulWidget {
  const AppointmentHome({super.key});

  @override
  State<AppointmentHome> createState() => _AppointmentHomeState();
}

class _AppointmentHomeState extends State<AppointmentHome>  {
  final ScrollController _timeLineScrollController = ScrollController();
  final ScrollController _appointmentListScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<AppointmentBloc>().add(GetAllAppointmentRecordEvent());
  }

  @override
  void didChangeDependencies() {
    // No additional dependencies to handle for now
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timeLineScrollController.dispose();
    _appointmentListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: BlocListener<AppointmentBloc, AppointmentState>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if (state.status == BlocStatus.error) {
                  ToastManager.showToast(
                      context: context,
                      message: state.errorMessage ?? 'An error occurred');
                  return;
                }
                if ([CreateAppointmentRecordState, CancelAppointmentRecordState]
                        .contains(state.runtimeType) &&
                    state.status == BlocStatus.success) {
                  context
                      .read<AppointmentBloc>()
                      .add(GetAllAppointmentRecordEvent());
                }
              },
              child: Shimmer(
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
                          AddButtonWidget(
                            onPressed: () {
                              context.pushNamed(
                                  RouteDefine.createAppointmentChooseProvider);
                            },
                          )
                        ]),
                    const SizedBox(height: 16),
                    WeekDaysRowWidget(),
                    ShadowEdgeWidget(),
                    NotificationListener<ScrollNotification>(
                      //TODO: Hanle later, wrap in notification of scroll controller for now in order to avoid affect the appearance of bottom nav bar
                      onNotification: (notification) {
                        return true;
                      },
                      child: BlocBuilder<AppointmentBloc, AppointmentState>(
                        buildWhen: (previous, current) =>
                            previous.status != current.status &&
                            ![
                              CreateAppointmentRecordState,
                              CancelAppointmentRecordState
                            ].contains(current.runtimeType),
                        builder: (context, state) {
                          //todo: handle data for dis widget later on
                          // List<AppointmentRecordEntity> appointmentRecords = [];
                          bool isLoading = true;
                          if (state.status == BlocStatus.success) {
                            isLoading = false;
                            // appointmentRecords =
                            //     state.data as List<AppointmentRecordEntity>;
                          }
                          return ShimmerLoading(
                              isLoading: isLoading,
                              child: SizedBox(
                                  height: 200.r,
                                  child: TimelineSchedule(
                                    scrollController: _timeLineScrollController,
                                  )));
                        },
                      ),
                    ),
                    ShadowEdgeWidget(),
                    BlocBuilder<AppointmentBloc, AppointmentState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status &&
                          ![
                            CreateAppointmentRecordState,
                            CancelAppointmentRecordState
                          ].contains(current.runtimeType),
                      builder: (context, state) {
                        List<AppointmentRecordEntity> appointmentRecords = [];
                        bool isLoading = true;
                        if (state.status == BlocStatus.success) {
                          isLoading = false;
                          appointmentRecords =
                              state.data as List<AppointmentRecordEntity>;
                        }
                        return ShimmerLoading(
                          isLoading: isLoading,
                          child: ListView(
                            controller: _appointmentListScrollController,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              ListAppointmentRecordWidget(
                                  appointmentRecords: isLoading
                                      ? List.generate(
                                          3,
                                          (index) => AppointmentRecordEntity(),
                                        )
                                      : appointmentRecords),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              )),
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
            onCancel: () {
              if (appointmentRecords[index].id != null) {
                context.read<AppointmentBloc>().add(
                    DeleteAppointmentRecordEvent(
                        appointmentId: appointmentRecords[index].id!));
              }
            },
            doctorType: appointmentRecords[index]
                .doctor
                ?.doctorProfile
                ?.specialization
                ?.name
                .toUpperCase(),
            doctorRating: appointmentRecords[index]
                .doctor
                ?.doctorProfile
                ?.rating
                ?.toInt(),
            doctorName: appointmentRecords[index].doctor?.firstName,
            time: appointmentRecords[index].scheduledAt != null
                ? DateConverter.convertToYearMonthDay(
                    appointmentRecords[index].scheduledAt!,
                  )
                : null,
            date: appointmentRecords[index].scheduledAt != null
                ? DateConverter.convertToHourMinuteSecond(
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
  final VoidCallback? onPressed;
  const AddButtonWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            enableFeedback: true,
            backgroundColor:
                WidgetStateProperty.all(ColorManager.buttonEnabledColorLight),
            padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(horizontal: 16, vertical: 8))),
        icon: Icon(
          Icons.add,
          size: 30.r,
          color: ColorManager.iconButtonColorLight,
        ),
        onPressed: onPressed,
        label: Text(
          "Add",
          style: StyleManager.buttonText,
        ));
  }
}

class AppointmentCard extends StatelessWidget {
  final String? doctorType;
  final int? doctorRating;
  final String? doctorName;
  final String? time;
  final String? date;
  final bool isCompleted;
  final VoidCallback? onCancel;

  const AppointmentCard({
    super.key,
    this.onCancel,
    this.doctorType,
    this.doctorRating,
    this.doctorName,
    this.time,
    this.date,
    this.isCompleted = false,
  });

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
                  doctorName ?? "Loading...",
                  style: StyleManager.buttonText,
                ),
                const SizedBox(height: 8),
                Text(doctorType ?? "Loading...",
                    style: StyleManager.buttonText),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index <= (doctorRating ?? 0)
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  time ?? "Loading...",
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
                          date ?? "Loading...",
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
                          time ?? "Loading...",
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
          if (!isCompleted) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
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
