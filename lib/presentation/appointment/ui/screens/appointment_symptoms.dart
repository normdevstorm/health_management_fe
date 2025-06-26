import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/domain/address/entities/address_entity.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/domain/geolocator/geolocator_usecase.dart';
import 'package:health_management/domain/health_provider/entities/health_provider_entity.dart';
import 'package:health_management/presentation/appointment/bloc/appointment/appointment_bloc.dart';
import 'package:health_management/presentation/appointment/bloc/health_provider/health_provider_bloc.dart';
import 'package:health_management/presentation/appointment/bloc/symptoms/symptoms_bloc.dart';
import 'package:logger/logger.dart';

class CreateAppointmentWithAIScreen extends StatefulWidget {
  const CreateAppointmentWithAIScreen({super.key});

  @override
  State<CreateAppointmentWithAIScreen> createState() =>
      _CreateAppointmentWithAIScreenState();
}

class _CreateAppointmentWithAIScreenState
    extends State<CreateAppointmentWithAIScreen> {
  final List<String> _selectedSymptoms = [];
  final List<HealthProviderEntity> _healthProviderList = [];
  ValueNotifier<HealthProviderEntity?> nearestHealthProviderNotifier =
      ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Appointment with AI'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: BlocConsumer<SymptomsBloc, SymptomsState>(
          listener: (context, state) {
            if (state.status == BlocStatus.error) {
              ToastManager.showToast(
                context: context,
                message: state.errorMessage ?? 'An error occurred',
              );
            }
          },
          builder: (context, state) {
            print(
                'SymptomsState: ${state.status}, Symptoms: ${state.symptoms.length}'); // Debug
            return SingleChildScrollView(
              child: BlocListener<HealthProviderBloc, HealthProviderState>(
                listener: (context, state) async {
                  if (state.status == BlocStatus.error) {
                    ToastManager.showToast(
                      context: context,
                      message: state.errorMessage ??
                          'An error occurred while fetching health providers',
                    );
                  }

                  if (state.status == BlocStatus.success) {
                    _healthProviderList.clear();
                    _healthProviderList
                        .addAll(state.data as List<HealthProviderEntity>);
                    if (_healthProviderList.isNotEmpty) {
                      nearestHealthProviderNotifier.value =
                          await getClosestHealthProvider();
                      getIt<Logger>().i(
                          'Nearest Health Provider: ${nearestHealthProviderNotifier.value?.name ?? 'Unknown'}');
                    }
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Symptoms',
                      style: StyleManager.title.copyWith(fontSize: 20.sp),
                    ),
                    SizedBox(height: 16.h),
                    state.status == BlocStatus.loading
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownButtonFormField2<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              labelText: 'Symptoms',
                            ),
                            isExpanded: true,
                            hint: Text(
                              'Select Symptoms',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            items: state.symptoms.map((symptom) {
                              return DropdownMenuItem<String>(
                                value: symptom,
                                child: Container(
                                  color: _selectedSymptoms.contains(symptom)
                                      ? ColorManager.buttonEnabledColorLight
                                          .withOpacity(0.2)
                                      : null,
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value:
                                            _selectedSymptoms.contains(symptom),
                                        onChanged: null,
                                        activeColor: ColorManager
                                            .buttonEnabledColorLight,
                                        checkColor: Colors.white,
                                      ),
                                      Expanded(
                                        child: Text(
                                          symptom,
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            value: null,
                            onChanged: state.status == BlocStatus.loading
                                ? null
                                : (String? value) {
                                    if (value != null) {
                                      setState(() {
                                        if (_selectedSymptoms.contains(value)) {
                                          _selectedSymptoms.remove(value);
                                        } else {
                                          _selectedSymptoms.add(value);
                                        }
                                      });
                                    }
                                  },
                            selectedItemBuilder: (context) =>
                                state.symptoms.map((_) {
                              return Text(
                                _selectedSymptoms.isEmpty
                                    ? 'Select Symptoms'
                                    : _selectedSymptoms.join(', '),
                                style: TextStyle(fontSize: 12.sp),
                              );
                            }).toList(),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 400.h,
                              width: MediaQuery.of(context).size.width - 32.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: WidgetStateProperty.all(6),
                                thumbVisibility: WidgetStateProperty.all(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.zero,
                            ),
                          ),
                    SizedBox(height: 24.h),
                    ElevatedButton(
                      onPressed: _selectedSymptoms.isEmpty ||
                              state.status == BlocStatus.loading
                          ? null
                          : () {
                              context.read<SymptomsBloc>().add(
                                    DiagnoseSymptomsEvent(
                                      symptoms: _selectedSymptoms,
                                    ),
                                  );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.buttonEnabledColorLight,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                      ),
                      child: state.status == BlocStatus.loading
                          ? SizedBox(
                              width: 20.r,
                              height: 20.r,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Proceed'),
                    ),
                    if (state.diagnosisResponse != null) ...[
                      SizedBox(height: 24.h),
                      Text(
                        'Diagnosis',
                        style: StyleManager.title.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 8.h),
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Disease: ${state.diagnosisResponse!.finalDiagnosis['disease']}',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Text(
                                'Department: ${state.diagnosisResponse!.finalDiagnosis['department']}',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Text(
                                'Confidence: ${state.diagnosisResponse!.finalDiagnosis['confidence']}%',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Recommendations',
                        style: StyleManager.title.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 8.h),
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Department: ${state.diagnosisResponse!.recommendations['department']}',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Text(
                                'Urgency: ${state.diagnosisResponse!.recommendations['urgency']}',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Text(
                                'Precautions:',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              ...(state.diagnosisResponse!
                                          .recommendations['precautions']
                                      as List<dynamic>)
                                  .map<Widget>((precaution) => Text(
                                        '- $precaution',
                                        style: TextStyle(fontSize: 14.sp),
                                      ))
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<HealthProviderBloc, HealthProviderState>(
                        builder: (context, state) {
                          if (state.status == BlocStatus.loading) {
                            return Center(
                              child: SizedBox(
                                width: 24.r,
                                height: 24.r,
                                child: const CircularProgressIndicator(),
                              ),
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: SizedBox(
                              width: double.infinity,
                              child: ValueListenableBuilder(
                                valueListenable: nearestHealthProviderNotifier,
                                builder:
                                    (context, nearestHealthProvider, child) =>
                                        ElevatedButton(
                                  onPressed: nearestHealthProvider == null
                                      ? null
                                      : () async {
                                          // Handle appointment scheduling
                                          String suggestedSpecialization =
                                              context
                                                      .read<SymptomsBloc>()
                                                      .state
                                                      .diagnosisResponse!
                                                      .recommendations[
                                                  'department'];
                                          context.read<AppointmentBloc>().add(
                                                  CollectDataHealthProviderEvent(
                                                      AppointmentRecordEntity(
                                                healthProvider:
                                                    nearestHealthProviderNotifier
                                                        .value,
                                              )));
                                          GoRouter.of(context).pushNamed(
                                              RouteDefine
                                                  .createAppointmentChooseDoctor,
                                              extra:
                                                  nearestHealthProviderNotifier
                                                          .value!.doctors
                                                          ?.where(
                                                            (e) =>
                                                                e.doctorProfile
                                                                    ?.specialization ==
                                                                HospitalSpecialty
                                                                    .fromName(
                                                                        suggestedSpecialization),
                                                          )
                                                          .toList() ??
                                                      []);
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        ColorManager.buttonEnabledColorLight,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 12.h,
                                    ),
                                  ),
                                  child: Text(
                                    'Schedule an appointment',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<HealthProviderEntity> getClosestHealthProvider() async {
    double closestDistance = double.infinity;
    HealthProviderEntity nearestHealthProvider = _healthProviderList.first;
    await Future.forEach(_healthProviderList, (e) async {
      if (e.address == null ||
          (e.address?.addressLine1 == '' ||
              e.address?.addressLine2 == '' ||
              e.address?.city == '')) return;
      double distance = await getIt<GeolocatorUsecase>()
          .getDistanceBetweenDestinationAndCurrentPositionInKilometers(
              e.address ?? AddressEntity());
      if (distance < closestDistance) {
        closestDistance = distance;
        nearestHealthProvider = e;
      }
    });
    return nearestHealthProvider;
  }
}
