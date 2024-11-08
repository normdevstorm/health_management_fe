import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/domain/health_provider/entities/health_provider_entity.dart';
import 'package:health_management/presentation/appointment/bloc/appointment/appointment_bloc.dart';
import 'package:health_management/presentation/appointment/ui/widgets/health_provider_item.dart';
import 'package:health_management/presentation/appointment/ui/widgets/medical_department_item.dart';
import 'package:health_management/presentation/common/shimmer_loading.dart';

import '../../bloc/health_provider/health_provider_bloc.dart';

class ChooseHealthProviderScreen extends StatelessWidget {
  final ValueNotifier<int?> selectedHealthProviderNotifier =
      ValueNotifier(null);
  final ValueNotifier<int?> selectedHealthSpecialtyNotifier =
      ValueNotifier(null);
  List<HealthProviderEntity> healthProviders = [];
  ChooseHealthProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: BlocConsumer<HealthProviderBloc, HealthProviderState>(
            listener: (context, state) {
              if (state.status == BlocStatus.error) {
                ToastManager.showToast(
                    context: context, message: state.errorMessage!);
              }
            },
            builder: (context, state) {
              final bool isLoading = (state.status == BlocStatus.loading);
              if (state.status == BlocStatus.success) {
                healthProviders = state.data as List<HealthProviderEntity>;
              }
              return Shimmer(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      30.verticalSpace,
                      Text(
                        "Health Provider",
                        style: StyleManager.title.copyWith(fontSize: 20.sp),
                      ),
                      10.verticalSpace,
                      ShimmerLoading(
                        isLoading: isLoading,
                        child: SizedBox(
                          height: 200.h,
                          child: HealthProviderListWidget(
                              isLoading: isLoading,
                              healthProviders: healthProviders,
                              selectedHealthProviderNotifier:
                                  selectedHealthProviderNotifier),
                        ),
                      ),
                      20.verticalSpace,
                      Text(
                        "Health Specialties",
                        style: StyleManager.title.copyWith(fontSize: 20.sp),
                      ),
                      10.verticalSpace,
                      ShimmerLoading(
                        isLoading: isLoading,
                        child: SizedBox(
                          height: 250.h,
                          child: MedicalDepartmentListView(
                            selectedHealthSpecialty:
                                selectedHealthSpecialtyNotifier,
                            hospitalSpecialties: HospitalSpecialty.values,
                          ),
                        ),
                      )
                    ]),
              );
            },
          ),
        ),
        Positioned(
          bottom: 100.h,
          left: 14.w,
          right: 14.w,
          child: InkWell(
            splashColor: ColorManager.buttonEnabledColorLight,
            onTap: () {
              if (selectedHealthProviderNotifier.value == null) {
                ToastManager.showToast(
                    context: context,
                    message: "Please select a health provider");
                return;
              }

              context.read<AppointmentBloc>().add(
                      CreateAppointmentRecordChooseHealthProviderEvent(
                          AppointmentRecordEntity(
                    healthProvider:
                        healthProviders[selectedHealthProviderNotifier.value!],
                  )));
              context.pushNamed(RouteDefine.createAppointmentChooseDoctor,
                  extra: healthProviders[selectedHealthProviderNotifier.value!]
                          .doctors ??
                      []);
            },
            child: Icon(
              Icons.arrow_forward_outlined,
              size: 30.r,
            ),
          ),
        )
      ],
    );
  }
}

class HealthProviderListWidget extends StatelessWidget {
  const HealthProviderListWidget({
    super.key,
    required this.isLoading,
    required this.healthProviders,
    required this.selectedHealthProviderNotifier,
  });

  final bool isLoading;
  final List<HealthProviderEntity> healthProviders;
  final ValueNotifier<int?> selectedHealthProviderNotifier;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: isLoading ? 5 : healthProviders.length,
      itemBuilder: (context, index) {
        final provider =
            isLoading ? HealthProviderEntity() : healthProviders[index];
        return ValueListenableBuilder(
          valueListenable: selectedHealthProviderNotifier,
          builder: (context, selectedIndex, child) => HealthProviderItem(
            onTap: () {
              selectedHealthProviderNotifier.value =
                  (selectedIndex == index) ? null : index;
            },
            isSelected: selectedIndex == index,
            title: provider.name ?? "",
            address: provider.address?.city ?? "",
            distance: "1 km",
            icon: Icons.local_hospital,
            doctors: provider.doctors ?? [],
          ),
        );
      },
    );
  }
}

class MedicalDepartmentListView extends StatelessWidget {
  final List<HospitalSpecialty> hospitalSpecialties;
  final ValueNotifier<int?> selectedHealthSpecialty;
  const MedicalDepartmentListView(
      {required this.selectedHealthSpecialty,
      this.hospitalSpecialties = HospitalSpecialty.values,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: hospitalSpecialties.length,
      itemBuilder: (context, index) {
        return ValueListenableBuilder(
          valueListenable: selectedHealthSpecialty,
          builder: (context, selectedIndex, child) => MedicalDepartmentItem(
            onTap: () {
              selectedHealthSpecialty.value =
                  (selectedIndex == index) ? null : index;
            },
            isSelected: selectedIndex == index,
            departmentName: hospitalSpecialties[index].name,
            doctorsCount: 10,
          ),
        );
      },
    );
  }
}
