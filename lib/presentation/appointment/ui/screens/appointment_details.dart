// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/size_manager.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/app/route/app_routing.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/domain/chat/models/user_model.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/presentation/common/shimmer_loading.dart';

import '../../../../app/managers/local_storage.dart';
import '../../../../app/route/route_define.dart';
import '../../../../domain/health_provider/entities/health_provider_entity.dart';
import '../../../../domain/prescription/entities/prescription_entity.dart';
import '../../../chat/bloc/contacts/contacts_cubit.dart';
import '../../../chat/ui/main/home/chat_screen/chat_page.dart';
import '../../bloc/appointment/appointment_bloc.dart';
import '../widgets/common_separator.dart';

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({required this.appointmentId, super.key});
  final int appointmentId;

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  AppointmentRecordEntity appointmentRecordEntity =
      const AppointmentRecordEntity();
  var _isDoctor = false;

  @override
  void initState() {
    super.initState();
    context
        .read<AppointmentBloc>()
        .add(GetAppointmentDetailEvent(appointmentId: widget.appointmentId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<AppointmentBloc, AppointmentState>(
            listener: (context, state) async {
              if (state.status == BlocStatus.loading) {
                _isDoctor = (Role.doctor ==
                    await SharedPreferenceManager.getUserRole());
                return;
              }

              if (state.status == BlocStatus.error) {
                ToastManager.showToast(
                    context: context,
                    message: state.errorMessage ?? "Something went wrong!!!");
              }
            },
            listenWhen: (previous, current) =>
                previous != current && current is GetAppointmentDetailState,
            buildWhen: (previous, current) =>
                previous.status != current.status &&
                current is GetAppointmentDetailState,
            builder: (context, state) {
              bool isLoading = [BlocStatus.loading, BlocStatus.initial]
                  .contains(state.status);
              if (state.status == BlocStatus.success &&
                  state.data is AppointmentRecordEntity) {
                appointmentRecordEntity = state.data as AppointmentRecordEntity;
              }

              return ShimmerWidget(
                child: ShimmerLoading(
                  isLoading: isLoading && appointmentRecordEntity.id == null,
                  child: Column(
                    children: [
                      _buildSection(
                        height: 120.h,
                        context,
                        child: _buildDateTimeBox(
                            dateTime: appointmentRecordEntity.scheduledAt),
                      ),
                      _buildSection(
                        height: 280.h,
                        context,
                        child: _buildHealthProviderBox(
                            healthProvider:
                                appointmentRecordEntity.healthProvider),
                      ),
                      const SizedBox(width: 8),
                      _buildSection(
                        height: 150.h,
                        context,
                        child: _buildDoctorDetailsBox(
                            doctor: appointmentRecordEntity.doctor,
                            context: context),
                      ),
                      //TODO: Add responsiveness to note box
                      _buildSection(
                        height: 150.h,
                        context,
                        child:
                            _buildNotesBox(note: appointmentRecordEntity.note),
                      ),
                      const SizedBox(width: 8),
                      _buildSection(
                        height: 100.h,
                        context,
                        child: _buildPrescriptionBox(
                            appointmentId: appointmentRecordEntity.id,
                            prescription: appointmentRecordEntity.prescription,
                            context: context),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required Widget child, double? height}) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        // border: Border.all(color: Colors.blueAccent),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }

  Widget _buildDateTimeBox({DateTime? dateTime}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueAccent),
          ),
          padding:
              EdgeInsets.only(left: 5.w, right: 25.w, top: 5.h, bottom: 5.h),
          height: 100.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      '${dateTime != null ? DateFormat('MMM').format(dateTime) : ''} ${dateTime?.day ?? ''}',
                      style: TextStyle(fontSize: 30.sp))),
              Text(DateFormat('EEEE').format(dateTime ?? DateTime.now()),
                  style: TextStyle(fontSize: 16.sp)),
              10.verticalSpace,
            ],
          ),
        ),
        8.horizontalSpace,
        Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueAccent),
          ),
          padding:
              EdgeInsets.only(left: 5.w, right: 25.w, top: 5.h, bottom: 5.h),
          height: 100.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                      DateFormat('h:mm a').format(dateTime ?? DateTime.now()),
                      style: TextStyle(fontSize: 30.sp))),
              Text('Time', style: TextStyle(fontSize: 16.sp)),
              10.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthProviderBox({HealthProviderEntity? healthProvider}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent)),
              child: Icon(
                Icons.local_hospital,
                size: 35.r,
                color: Colors.blueAccent,
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Text(healthProvider?.name ?? 'Loading',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent)),
            ),
          ],
        ),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('City',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                Text(healthProvider?.address?.city ?? "Loading",
                    style: TextStyle(fontSize: 16.sp)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('District',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                Text(healthProvider?.address?.addressLine1 ?? "Loading",
                    style: TextStyle(fontSize: 16.sp)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Street',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                Text(healthProvider?.address?.streetNumber ?? "Loading",
                    style: TextStyle(fontSize: 16.sp)),
              ],
            ),
          ],
        ),
        8.verticalSpace,
        CommonSeparator(
          height: 1.sp,
          color: Colors.grey.shade400,
        ),
        8.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(
              children: [
                Text("Distance"),
                Text("1 KM AWAY"),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                fit: BoxFit.fitWidth,
                'assets/images/placeholder.png',
                width: 200.w,
                height: 80.h,
              ),
            ),
          ],
        ),
        15.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  // elevation: WidgetStateProperty.all(10.h),
                  backgroundColor: WidgetStateProperty.all(
                      ColorManager.buttonEnabledColorLight),
                  fixedSize: WidgetStatePropertyAll(Size(140.w, 35.h))),
              onPressed: () {},
              child: const Text(
                'Copy Direction',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  // elevation: WidgetStateProperty.all(10.h),
                  backgroundColor: WidgetStateProperty.all(
                      ColorManager.buttonEnabledColorLight),
                  fixedSize: WidgetStatePropertyAll(Size(140.w, 35.h))),
              onPressed: () {},
              child: const Text(
                'Open Maps',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        10.verticalSpace,
      ],
    );
  }

  Widget _buildDoctorDetailsBox(
      {UserEntity? doctor, required BuildContext context}) {
    UserChatModel? doctorChatModel;
    return BlocBuilder<ContactsCubit, ContactsState>(
      builder: (context, state) {
        if (state is GetAllContactsSuccess) {
          try {
            doctorChatModel = state.contacts.firstWhere((element) =>
                element.mainServiceId == doctor?.doctorProfile?.id &&
                element.role == Role.doctor);
          } catch (e) {
            doctorChatModel = null;
          }
        }
        return Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.person,
                    size: 50.r,
                    color: Colors.blueAccent,
                  ),
                ),
                15.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${doctor?.firstName} ${doctor?.lastName}',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    Text(
                        doctor?.doctorProfile?.specialization?.name ??
                            "Loading",
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 18.r,
                    );
                  }),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                  ),
                  onPressed: () {
                    if (doctorChatModel != null) {
                      context.pushNamed(RouteDefine.appointmentDetailsChat,
                          extra: ChatPageData(
                            name: doctorChatModel!.userName,
                            receiverId: doctorChatModel!.uid,
                            profilePicture: doctorChatModel!.profileImage,
                            isGroupChat: false,
                          ),
                          pathParameters: {
                            'userId': doctorChatModel!.userName,
                            'appointmentId': widget.appointmentId.toString(),
                          });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.chat, color: Colors.white),
                      5.horizontalSpace,
                      const Text('Chat', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildNotesBox({String? note}) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueAccent),
          ),
          child: Row(
            children: [
              Container(
                width: 5,
                height: double.infinity,
                color: Colors.blueAccent,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(note ?? 'No notes pinned for this appointment',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              'Note',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrescriptionBox(
      {int? appointmentId,
      PrescriptionEntity? prescription,
      required BuildContext context}) {
    var isPrescriptionDetailsAvailable =
        (prescription?.details ?? []).isNotEmpty;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueAccent),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.medication,
            size: 50.r,
            color: Colors.blueAccent,
          ),
        ),
        15.horizontalSpace,
        Expanded(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Prescription',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  15.verticalSpace,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150.w, 40.h),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Add your onPressed code here!
                      if ((appointmentId != null &&
                              isPrescriptionDetailsAvailable) ||
                          _isDoctor) {
                        context.pushNamed(
                            RouteDefine.appointmentDetailsPrescription,
                            extra: prescription,
                            pathParameters: {
                              'appointmentId': appointmentId.toString(),
                            });
                      }
                    },
                    child: const Text('See details',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Chip(
                  label: Text(
                    isPrescriptionDetailsAvailable
                        ? 'Available'
                        : 'Not Available',
                    style: TextStyle(
                      color: isPrescriptionDetailsAvailable
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: isPrescriptionDetailsAvailable
                            ? Colors.green
                            : Colors.red),
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
