import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/app/utils/date_converter.dart';
import 'package:health_management/app/utils/local_notification/notification_service.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import '../../../../app/managers/toast_manager.dart';
import '../../../../app/route/route_define.dart';
import '../../../../domain/prescription/entities/prescription_entity.dart';
import '../../../common/custom_network_image.dart';
import '../../../common/shimmer_loading.dart';
import '../../bloc/appointment/appointment_bloc.dart';
import '../widgets/shadow_edge.dart';

class AppointmentHome extends StatefulWidget {
  const AppointmentHome({super.key});

  @override
  State<AppointmentHome> createState() => _AppointmentHomeState();
}

class _AppointmentHomeState extends State<AppointmentHome> {
  final ScrollController _timeLineScrollController = ScrollController();
  final ScrollController _appointmentListScrollController = ScrollController();
  final ValueNotifier<bool> _isDoctorNotifier = ValueNotifier(false);
  final EventController _eventController = EventController();
  final GlobalKey<DayViewState> _dayViewStateKey = GlobalKey<DayViewState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    context.read<AppointmentBloc>().add(const GetAllAppointmentRecordEvent());
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

  void _updateEvents(List<AppointmentRecordEntity> activeAppointmentRecords) {
    List<CalendarEventData<Object?>> events = activeAppointmentRecords.map((e) {
      return CalendarEventData(
        date: e.scheduledAt!,
        startTime: e.scheduledAt!,
        endTime: e.scheduledAt!.add(const Duration(hours: 1)),
        title: e.doctor?.firstName ?? 'Doctor Name',
        description:
            e.doctor?.doctorProfile?.specialization?.name.toUpperCase() ?? '',
      );
    }).toList();

    _eventController.removeWhere((element) => !activeAppointmentRecords.any(
        (e) =>
            e.doctor?.firstName == element.title &&
            e.scheduledAt == element.startTime));
    _eventController.addAll(events);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          context
              .read<AppointmentBloc>()
              .add(const GetAllAppointmentRecordEvent());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: BlocListener<AppointmentBloc, AppointmentState>(
                listenWhen: (previous, current) => previous != current,
                listener: (context, state) async {
                  if (state.status == BlocStatus.loading) {
                    _isDoctorNotifier.value = (Role.doctor ==
                        await SharedPreferenceManager.getUserRole());
                    return;
                  }

                  if (state.status == BlocStatus.error) {
                    ToastManager.showToast(
                        context: context,
                        message: state.errorMessage ?? 'An error occurred');
                    return;
                  }
                  if ([
                        CreateAppointmentRecordState,
                        CancelAppointmentRecordState,
                      ].contains(state.runtimeType) &&
                      state.status == BlocStatus.success) {
                    context
                        .read<AppointmentBloc>()
                        .add(const GetAllAppointmentRecordEvent());
                  }
                },
                child: ShimmerWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          DateFormat(DateFormat.YEAR_MONTH_DAY)
                              .format(DateTime.now()),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Today',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            ValueListenableBuilder(
                              valueListenable: _isDoctorNotifier,
                              builder: (context, disabled, child) => disabled
                                  ? const SizedBox()
                                  : AddButtonWidget(
                                      onPressed: () async {
                                        //TODO: TEMPORARILY USED FOR PAYMENT FUNCTIONALITY
                                        // ZaloPayOrderRequest zaloPayRequest =
                                        //     ZaloPayOrderRequest(
                                        //   amount: 200000,
                                        //   appId: 2553,
                                        //   appUser: 'Android_Demo',
                                        //   appTime: DateTime.now()
                                        //       .millisecondsSinceEpoch,
                                        //   embedData: '{}',
                                        //   item: '[]',
                                        //   bankCode: 'zalopayapp',
                                        //   description: 'Thanh toán đơn hàng',
                                        //   // callbackUrl:
                                        //   //     'health_management_zalopay.dev://app',
                                        // );
                                        // Map<String, String> hMacAndTransId =
                                        //     await ZalopayService
                                        //         .getHMacAndTransId(
                                        //   amount:
                                        //       zaloPayRequest.amount.toString(),
                                        //   appId:
                                        //       zaloPayRequest.appId.toString(),
                                        //   appUser: zaloPayRequest.appUser,
                                        //   appTime:
                                        //       zaloPayRequest.appTime.toString(),
                                        //   embedData: zaloPayRequest.embedData,
                                        //   items: zaloPayRequest.item,
                                        //   appTransId: zaloPayRequest.appTransId,
                                        // );

                                        // ZaloPayOrderResponse
                                        //     zaloPayOrderResponse =
                                        //     await getIt<ZalopayApi>().createOrder(
                                        //         zaloPayRequest.copyWith(
                                        //             mac: hMacAndTransId['mac'],
                                        //             appTransId: hMacAndTransId[
                                        //                 'app_trans_id']));

                                        context.pushNamed(
                                            RouteDefine // context.pushNamed(RouteDefine
                                                .createAppointmentChooseProvider);

                                        // String result =
                                        //     await ZalopayService.payOrder(
                                        //             zaloPayOrderResponse) ??
                                        //         "Payment failed";
                                        // print(result);
                                      },
                                    ),
                            )
                          ]),
                      const SizedBox(height: 16),
                      WeekDaysRowWidget(
                        enableSelection: false,
                      ),
                      const ShadowEdgeWidget(),
                      NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          return true;
                        },
                        child: BlocBuilder<AppointmentBloc, AppointmentState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status &&
                              ![
                                CreateAppointmentRecordState,
                                CancelAppointmentRecordState,
                                GetAppointmentDetailState,
                                UpdatePrescriptionState,
                              ].contains(current.runtimeType),
                          builder: (context, state) {
                            List<AppointmentRecordEntity>
                                activeAppointmentRecords = [];
                            List<AppointmentRecordEntity> appointmentRecords =
                                [];
                            if (state.status == BlocStatus.success) {
                              if (state.data is List<AppointmentRecordEntity>) {
                                appointmentRecords =
                                    state.data as List<AppointmentRecordEntity>;
                                activeAppointmentRecords =
                                    appointmentRecords.where(
                                  (element) {
                                    return element.status !=
                                        AppointmentStatus.cancelled;
                                  },
                                ).toList();
                                _updateEvents(activeAppointmentRecords);
                              }
                            }
                            return SizedBox(
                                height: 200.r,
                                child: DayView(
                                    scrollOffset:
                                        DateTime.now().hour * 60 * 0.7,
                                    scrollPhysics:
                                        const AlwaysScrollableScrollPhysics(),
                                    key: _dayViewStateKey,
                                    showVerticalLine: false,
                                    controller: _eventController,
                                    liveTimeIndicatorSettings:
                                        const LiveTimeIndicatorSettings(
                                      color: Colors.red,
                                    ),
                                    keepScrollOffset: true,
                                    headerStyle: const HeaderStyle(
                                      headerTextStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    heightPerMinute: 0.7.sp,
                                    eventTileBuilder: (date, events, boundary,
                                            startDuration, endDuration) =>
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.lightBlue,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                events.first.title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.sp),
                                              ),
                                              Text(
                                                events.first.description ?? '',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10.sp),
                                              ),
                                            ],
                                          ),
                                        )));
                          },
                        ),
                      ),
                      const ShadowEdgeWidget(),
                      BlocConsumer<AppointmentBloc, AppointmentState>(
                        listenWhen: (previous, current) =>
                            previous.status != current.status &&
                            ![
                              CreateAppointmentRecordState,
                              CancelAppointmentRecordState,
                              GetAppointmentDetailState,
                              UpdatePrescriptionState
                            ].contains(current.runtimeType),
                        listener: (context, state) {},
                        buildWhen: (previous, current) =>
                            previous.status != current.status &&
                            ![
                              CreateAppointmentRecordState,
                              CancelAppointmentRecordState,
                              GetAppointmentDetailState,
                              UpdatePrescriptionState
                            ].contains(current.runtimeType),
                        builder: (context, state) {
                          List<AppointmentRecordEntity>
                              activeAppointmentRecords = [];
                          List<AppointmentRecordEntity> appointmentRecords = [];
                          bool isLoading = true;
                          if (state.status == BlocStatus.success) {
                            isLoading = false;
                            if (state.data is List<AppointmentRecordEntity>) {
                              appointmentRecords =
                                  state.data as List<AppointmentRecordEntity>;
                              activeAppointmentRecords =
                                  appointmentRecords.where(
                                (element) {
                                  return element.status !=
                                      AppointmentStatus.cancelled;
                                },
                              ).toList();
                              activeAppointmentRecords.sort((a, b) {
                                return 0 -
                                    a.scheduledAt!.compareTo(b.scheduledAt!);
                              });
                            }
                          }
                          return ListView(
                            controller: _appointmentListScrollController,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              ListAppointmentRecordWidget(
                                  isLoading: isLoading,
                                  isForPatient: !_isDoctorNotifier.value,
                                  appointmentRecords: isLoading
                                      ? List.generate(
                                          3,
                                          (index) =>
                                              const AppointmentRecordEntity(),
                                        )
                                      : activeAppointmentRecords),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                )),
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
    required this.isForPatient,
    required this.isLoading,
  });

  final List<AppointmentRecordEntity> appointmentRecords;
  final bool isForPatient;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(
        appointmentRecords.length,
        (index) => Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ShimmerLoading(
            isLoading: isLoading,
            child: isForPatient
                ? AppointmentCard.doctor(
                    id: appointmentRecords[index].id,
                    prescription: appointmentRecords[index].prescription,
                    onCancel: () async {
                      if (appointmentRecords[index].id != null) {
                        context.read<AppointmentBloc>().add(
                            CancelAppointmentRecordEvent(
                                userId: appointmentRecords[index].user?.id ?? 0,
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
                    date: appointmentRecords[index].scheduledAt != null
                        ? DateConverter.convertToYearMonthDay(
                            appointmentRecords[index].scheduledAt!,
                          )
                        : null,
                    time: appointmentRecords[index].scheduledAt != null
                        ? DateConverter.convertToHourMinuteSecond(
                            appointmentRecords[index].scheduledAt!,
                          )
                        : null,
                    isCompleted: appointmentRecords[index].status ==
                        AppointmentStatus.completed,
                    avatarUrl: appointmentRecords[index].doctor?.avatarUrl,
                  )
                : AppointmentCard.patient(
                    id: appointmentRecords[index].id,
                    prescription: appointmentRecords[index].prescription,
                    onCancel: () {
                      if (appointmentRecords[index].id != null) {
                        context.read<AppointmentBloc>().add(
                            CancelAppointmentRecordEvent(
                                userId: appointmentRecords[index].user?.id ?? 0,
                                appointmentId: appointmentRecords[index].id!));
                      }
                    },
                    patientName: appointmentRecords[index].user?.firstName,
                    patientCondition:
                        appointmentRecords[index].user?.gender ?? "Patient",
                    date: appointmentRecords[index].scheduledAt != null
                        ? DateConverter.convertToYearMonthDay(
                            appointmentRecords[index].scheduledAt!,
                          )
                        : null,
                    time: appointmentRecords[index].scheduledAt != null
                        ? DateConverter.convertToHourMinuteSecond(
                            appointmentRecords[index].scheduledAt!,
                          )
                        : null,
                    isCompleted: appointmentRecords[index].status ==
                        AppointmentStatus.completed,
                    avatarUrl: appointmentRecords[index].user?.avatarUrl,
                  ),
          ),
        ),
      ),
    );
  }
}

class WeekDaysRowWidget extends StatelessWidget {
  final int day = DateTime.now().weekday;
  final DateTime date = DateTime.now();
  final bool enableSelection;
  final ValueNotifier selectedDay = ValueNotifier<int>(DateTime.now().weekday);
  WeekDaysRowWidget({
    this.enableSelection = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(7, (index) {
        return ValueListenableBuilder(
          valueListenable: selectedDay,
          builder: (context, selectedDayValue, child) => WeekDayBox(
              enableSelection: enableSelection,
              day: day,
              date: date,
              index: index,
              isSelected: selectedDayValue == index + 1,
              onTap: () => _onDaySelected(index)),
        );
      }),
    );
  }

  void _onDaySelected(int index) {
    selectedDay.value = index + 1;
  }
}

class WeekDayBox extends StatelessWidget {
  const WeekDayBox({
    super.key,
    required this.index,
    required this.day,
    required this.date,
    this.onTap,
    this.isSelected = false,
    this.enableSelection = false,
  });

  final int day;
  final DateTime date;
  final int index;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool enableSelection;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (enableSelection && index + 1 >= day) ? onTap : null,
      child: Container(
        foregroundDecoration: enableSelection
            ? BoxDecoration(
                color: index + 1 >= day ? null : Colors.white.withOpacity(0.7),
              )
            : null,
        constraints: BoxConstraints.tight(Size(45.w, 70.h)),
        padding: EdgeInsets.only(top: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: ColorManager.buttonBorderColorLight,
          ),
          color: _enableHighlightButton
              ? ColorManager.buttonEnabledColorLight
              : ColorManager.buttonDisbledColorLight,
          boxShadow: [
            BoxShadow(
              color: ColorManager.buttonShadowColorLight,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
              style: StyleManager.buttonText.copyWith(
                color: _enableHighlightButton
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
                color: _enableHighlightButton ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _enableHighlightButton =>
      (index == (day - 1) && !enableSelection) ||
      (enableSelection && isSelected);
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
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8))),
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
  final int? id;
  final Role? role;
  final String? doctorType;
  final int? doctorRating;
  final String? userName;
  final String? avatarUrl;
  final String? time;
  final String? date;
  final bool isCompleted;
  final VoidCallback? onCancel;
  final PrescriptionEntity? prescription;

  factory AppointmentCard.doctor({
    int? id,
    String? doctorType,
    int? doctorRating,
    String? doctorName,
    String? avatarUrl,
    String? time,
    String? date,
    required bool isCompleted,
    VoidCallback? onCancel,
    PrescriptionEntity? prescription,
  }) {
    return AppointmentCard._(
      id: id,
      role: Role.doctor,
      doctorType: doctorType,
      doctorRating: doctorRating,
      userName: doctorName,
      avatarUrl: avatarUrl,
      time: time,
      date: date,
      isCompleted: isCompleted,
      onCancel: onCancel,
      prescription: prescription,
    );
  }

  factory AppointmentCard.patient({
    int? id,
    String? patientName,
    String? avatarUrl,
    String? patientCondition,
    String? time,
    String? date,
    required bool isCompleted,
    VoidCallback? onCancel,
    PrescriptionEntity? prescription,
  }) {
    return AppointmentCard._(
      id: id,
      doctorType: patientCondition,
      role: Role.user,
      doctorRating: null,
      userName: patientName,
      avatarUrl: avatarUrl,
      time: time,
      date: date,
      isCompleted: isCompleted,
      onCancel: onCancel,
      prescription: prescription,
    );
  }

  const AppointmentCard._({
    super.key,
    this.id,
    this.role,
    this.onCancel,
    this.doctorType,
    this.doctorRating,
    this.userName,
    this.avatarUrl,
    this.time,
    this.date,
    this.isCompleted = false,
    this.prescription,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(RouteDefine.appointmentDetails,
            extra: prescription,
            pathParameters: {'appointmentId': id.toString()});
      },
      child: Container(
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
              offset: const Offset(0, 5),
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
                    userName ?? "Loading...",
                    style: StyleManager.buttonText,
                  ),
                  const SizedBox(height: 8),
                  Text(doctorType ?? "Loading...",
                      style: StyleManager.buttonText),
                  if (role == Role.doctor) ...[
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index <= (doctorRating ?? 0)
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                        );
                      }),
                    )
                  ],
                  const SizedBox(height: 8),
                  Text(
                    DateConverter.getWeekdayString(
                        DateTime.tryParse(date ?? DateTime.now().toString()) ??
                            DateTime.now()),
                    style: StyleManager.buttonText,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              color: Color(0xFFEFE8E9)),
                          const SizedBox(width: 5),
                          Text(
                            date ?? "Loading...",
                            style: const TextStyle(
                                fontSize: 16, color: Color(0xFFEFE8E9)),
                          ),
                        ],
                      ),
                      16.horizontalSpace,
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              color: Color(0xFFEFE8E9)),
                          const SizedBox(width: 5),
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
                    child: CustomNetworkImage(avatarUrl: avatarUrl),
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
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.red),
                        side: WidgetStateProperty.all(
                          const BorderSide(color: Colors.white),
                        ),
                      ),
                      onPressed: onCancel,
                      child: Text(
                        isInThePast() ? 'Delete' : 'Cancel',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (!isInThePast()) ...[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (date != null && time != null) {
                            NotificationService.scheduleNotification(
                              appointmentId: id!,
                              title: 'Appointment Reminder',
                              body:
                                  'You have an appointment with ${role == Role.user ? "Patient" : "Doctor"} ${userName ?? "Loading..."} at ${DateFormat.jm().format(DateFormat.Hm().parse(time!))}',
                              scheduledTime:
                                  // DateTime.parse('${date!} ${time!}'),
                                  DateTime.now()
                                      .add(const Duration(seconds: 5)),
                            );
                          }
                        },
                        child: const Text('Remind Me'),
                      ),
                    ),
                  ]
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool isInThePast() {
    return (date == null) || (time == null)
        ? true
        : (DateTime.parse('${date!} ${time!}')).isBefore(DateTime.now());
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
