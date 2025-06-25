import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/domain/symptoms/entities/symptoms_entity.dart';
import 'package:health_management/presentation/appointment/bloc/symptoms/symptoms_bloc.dart';

class CreateAppointmentWithAIScreen extends StatefulWidget {
  const CreateAppointmentWithAIScreen({super.key});

  @override
  State<CreateAppointmentWithAIScreen> createState() =>
      _CreateAppointmentWithAIScreenState();
}

class _CreateAppointmentWithAIScreenState
    extends State<CreateAppointmentWithAIScreen> {
  final List<SymptomEntity> _selectedSymptoms = [];

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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Symptoms',
                  style: StyleManager.title.copyWith(fontSize: 20.sp),
                ),
                SizedBox(height: 16.h),
                state.status == BlocStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    : DropdownButtonFormField2<SymptomEntity>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          labelText: 'Symptoms',
                        ),
                        isExpanded: true,
                        hint: Text(
                          'Select Symptoms',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        items: state.symptoms.map((symptom) {
                          return DropdownMenuItem<SymptomEntity>(
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
                                    value: _selectedSymptoms.contains(symptom),
                                    onChanged: null,
                                    activeColor:
                                        ColorManager.buttonEnabledColorLight,
                                    checkColor: Colors.white,
                                  ),
                                  Expanded(
                                    child: Text(
                                      symptom.name,
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
                            : (SymptomEntity? value) {
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
                                : _selectedSymptoms
                                    .map((s) => s.name)
                                    .join(', '),
                            style: TextStyle(fontSize: 16.sp),
                          );
                        }).toList(),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 400.h, // Increased for 65 symptoms
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
                          final symptomNames =
                              _selectedSymptoms.map((s) => s.name).join(', ');
                          ToastManager.showToast(
                            context: context,
                            message: 'Selected symptoms: $symptomNames',
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
              ],
            );
          },
        ),
      ),
    );
  }
}
