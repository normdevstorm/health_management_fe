import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/app/route/app_routing.dart';
import 'package:health_management/data/prescription/models/request/prescription_ai_analysis_request.dart';
import 'package:health_management/domain/prescription/entities/prescription_details.dart';
import 'package:health_management/presentation/prescription/bloc/prescription_ai_analysis_bloc.dart';
import 'package:health_management/presentation/prescription/ui/widgets/pop_up_ai.dart';
import '../../../../app/managers/local_storage.dart';
import '../../../../domain/appointment/entities/appointment_record_entity.dart';
import '../../../../domain/prescription/entities/medication.dart';
import '../../../../domain/prescription/entities/prescription_entity.dart';
import '../../../appointment/bloc/appointment/appointment_bloc.dart';
import '../../../appointment/bloc/medication/medication_bloc.dart';

class MedicineListScreen extends StatefulWidget {
  const MedicineListScreen({
    this.prescriptions,
    required this.appointmentId,
    Key? key,
  }) : super(key: key);

  final List<PrescriptionDetails>? prescriptions;
  final int appointmentId;

  @override
  _MedicineListScreenState createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  var _enableUpdate = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final ValueNotifier<bool> _enablePopNotifier = ValueNotifier(false);
  final ValueNotifier<List<PrescriptionDetails>> _prescriptionListNotifier =
      ValueNotifier([]);
  List<Medication> _allMedications = [];
  List<Medication> _filteredMedications = [];

  bool get _validated => ![
        _nameController.text,
        _dosageController.text,
        _frequencyController.text,
        _instructionsController.text,
        _durationController.text
      ].any(
        (element) => element == '',
      );

  @override
  void dispose() {
    _nameFocusNode.removeListener(_handleFocusChange);
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_allMedications.any((med) =>
        med.name!.toLowerCase() == _nameController.text.toLowerCase())) {
      FocusScope.of(context).requestFocus(_nameFocusNode);
      ToastManager.showToast(
          context: context,
          message: 'Please select a valid medicine from the list',
          isErrorToast: true);
    }
  }
  // Prevent the TextField from losing focus

  @override
  initState() {
    super.initState();
    _nameFocusNode.addListener(_handleFocusChange);

    _prescriptionListNotifier.value = widget.prescriptions ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (!_enablePopNotifier.value) {
          _enablePopNotifier.value = true;
        } else {
          context.read<AppointmentBloc>().add(
              GetAppointmentDetailEvent(appointmentId: widget.appointmentId));
          _enablePopNotifier.value = false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Medicine List'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _savePrescription,
            ),
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<PrescriptionAiAnalysisBloc,
                PrescriptionAiAnalysisState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == BlocStatus.loading) {
                  showDialog(
                    context: context,
                    builder: (context) => Container(
                      alignment: Alignment.center,
                      width: 40.w,
                      height: 40.h,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                  return;
                }

                if (state.status == BlocStatus.success) {
                  context.pop();
                  _enablePopNotifier.value = false;
                  if (state.risks?.isEmpty ?? true) {
                    return;
                  }
                  showDialog(
                    barrierDismissible: true,
                    useRootNavigator: true,
                    useSafeArea: true,
                    context: context,
                    builder: (context) => Container(
                      alignment: Alignment.center,
                      width: 40.w,
                      height: 40.h,
                      child: PopupUI(
                        risks: state.risks!,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
          child: BlocConsumer<MedicationBloc, MedicationState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) async {
              if (state.status == BlocStatus.loading) {
                _enableUpdate = (Role.doctor ==
                    await SharedPreferenceManager.getUserRole());
                return;
              }
            },
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              _prescriptionListNotifier.value.sort((a, b) =>
                  (a.medication?.name ?? '')
                      .compareTo(b.medication?.name ?? ''));
              if (state.status == BlocStatus.success) {
                _allMedications = state.data as List<Medication>;
              }
              return Stack(
                children: [
                  ValueListenableBuilder(
                      valueListenable: _prescriptionListNotifier,
                      builder: (context, prescriptionList, child) {
                        return ListView.builder(
                          itemCount:
                              prescriptionList.length + (_enableUpdate ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == prescriptionList.length) {
                              return _buildAddMedicineBox(context);
                            }
                            return _enableUpdate
                                ? Dismissible(
                                    direction: DismissDirection.startToEnd,
                                    key: UniqueKey(),
                                    onDismissed: (direction) {
                                      _prescriptionListNotifier.value = List.of(
                                          _prescriptionListNotifier.value)
                                        ..removeAt(index);
                                    },
                                    background: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: const Icon(Icons.delete,
                                            color: Colors.white)),
                                    child: MedicineCard(
                                      name: prescriptionList[index]
                                          .medication
                                          ?.name,
                                      dosage: prescriptionList[index].dosage,
                                      expDate: prescriptionList[index]
                                          .medication
                                          ?.expDate,
                                      imageUrl: prescriptionList[index]
                                          .medication
                                          ?.imageUrl,
                                    ),
                                  )
                                : MedicineCard(
                                    name: prescriptionList[index]
                                        .medication
                                        ?.name,
                                    dosage: prescriptionList[index].dosage,
                                    expDate: prescriptionList[index]
                                        .medication
                                        ?.expDate,
                                    imageUrl: prescriptionList[index]
                                        .medication
                                        ?.imageUrl,
                                  );
                          },
                        );
                      }),
                  Positioned(
                    bottom: 80.h,
                    right: 15.w,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        splashColor:
                            ColorManager.primaryColorLight.withOpacity(0.5),
                        enableFeedback: true,
                        onTap: () {
                          context.read<PrescriptionAiAnalysisBloc>().add(
                              AnalyzePrescription(
                                  analyzedMedicines:
                                      PrescriptionAiAnalysisRequest(
                                          medicines: _prescriptionListNotifier
                                              .value
                                              .map((e) =>
                                                  e.medication?.name ?? '')
                                              .toList())));
                        },
                        child: Image.asset(
                          'assets/icons/ai_bot.png',
                          height: 40.h,
                          width: 40.w,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAddMedicineBox(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
            elevation: 10.h,
            enableDrag: true,
            context: context,
            builder: (parentContext) => StatefulBuilder(
                  builder: (context, setState) => KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                    if (!isKeyboardVisible) {
                      AppRouting.navBarVisibleNotifier.value = false;
                    }
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          color: const Color(0xFFefeff5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.r),
                              topRight: Radius.circular(30.r)),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              onSubmitted: (value) {
                                _handleFocusChange();
                              },
                              autofocus: true,
                              textInputAction:
                                  TextInputAction.next, // Moves focus to next.
                              focusNode: _nameFocusNode,
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _filteredMedications = _allMedications
                                      .where((med) => med.name!
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                });
                              },
                            ),
                            if (_filteredMedications.isNotEmpty &&
                                _nameController.text.isNotEmpty)
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // height: 200.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    itemCount: _filteredMedications.length,
                                    itemBuilder: (context, index) {
                                      final medication =
                                          _filteredMedications[index];
                                      return ListTile(
                                        tileColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        title: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            // border: Border.all(
                                            //     color: Colors.blueAccent),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                medication.name!,
                                                style: const TextStyle(
                                                    color: Colors.blueGrey),
                                              ),
                                              Divider(
                                                height: 1.5.r,
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _nameController.text =
                                                medication.name!;
                                            _filteredMedications.clear();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              )
                            else
                              Column(
                                children: [
                                  5.verticalSpace,
                                  TextField(
                                    autofocus: true,
                                    controller: _dosageController,
                                    textInputAction: TextInputAction
                                        .next, // Moves focus to next.

                                    decoration: const InputDecoration(
                                        labelText: 'Dosage'),
                                  ),
                                  5.verticalSpace,
                                  TextField(
                                    autofocus: true,
                                    controller: _frequencyController,
                                    textInputAction: TextInputAction
                                        .next, // Moves focus to next.

                                    decoration: const InputDecoration(
                                        labelText: 'Frequency'),
                                  ),
                                  5.verticalSpace,
                                  TextField(
                                    autofocus: true,
                                    controller: _durationController,
                                    textInputAction: TextInputAction
                                        .next, // Moves focus to next.

                                    decoration: const InputDecoration(
                                        labelText: 'Duration'),
                                  ),
                                  5.verticalSpace,
                                  TextField(
                                    autofocus: true,
                                    controller: _instructionsController,
                                    textInputAction: TextInputAction
                                        .next, // Moves focus to next.
                                    decoration: const InputDecoration(
                                        labelText: 'Instructions'),
                                  ),
                                ],
                              ),
                            15.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    _clearTextFields();
                                    context.pop();
                                    _enablePopNotifier.value = false;
                                  },
                                  child: const Text('Cancel',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                15.horizontalSpace,
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                  ),
                                  onPressed: () {
                                    if (_validated) {
                                      final selectedMedication =
                                          _allMedications.firstWhere(
                                              (med) =>
                                                  med.name ==
                                                  _nameController.text,
                                              orElse: () => Medication(
                                                  name: _nameController.text,
                                                  expDate: '2024-12-31'));
                                      final newMedicine = PrescriptionDetails(
                                        medication: selectedMedication,
                                        dosage: _dosageController.text,
                                        frequency: _frequencyController.text,
                                        duration: _durationController.text,
                                        instructions:
                                            _instructionsController.text,
                                      );
                                      _prescriptionListNotifier.value = List
                                          .from(_prescriptionListNotifier.value)
                                        ..add(newMedicine);
                                      _clearTextFields();
                                      context.pop();
                                      _enablePopNotifier.value = false;
                                    } else {
                                      ToastManager.showToast(
                                          context: context,
                                          message:
                                              "Please fill all the fields before submitting !!!",
                                          isErrorToast: true);
                                    }
                                  },
                                  child: const Text('Add',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ));
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.blueAccent),
              SizedBox(width: 8),
              Text(
                'Add Medicine',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearTextFields() {
    _nameController.clear();
    _dosageController.clear();
    _frequencyController.clear();
    _durationController.clear();
    _instructionsController.clear();
  }

  void _savePrescription() {
    final updatedAppointment = AppointmentRecordEntity(
      id: widget.appointmentId,
      prescription:
          PrescriptionEntity.update(details: _prescriptionListNotifier.value),
    );
    context
        .read<AppointmentBloc>()
        .add(UpdatePrescriptionEvent(appointment: updatedAppointment));
  }
}

class MedicineCard extends StatelessWidget {
  final String? name;
  final String? dosage;
  final String? expDate;
  final String? imageUrl;

  const MedicineCard({
    this.name,
    this.dosage,
    this.expDate,
    this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl ?? 'assets/images/placeholder.png',
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Dosage: $dosage',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Expiration Date: $expDate',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
