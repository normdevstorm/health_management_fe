import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';

import 'package:health_management/data/prescription/models/request/prescription_ai_analysis_request.dart';
import 'package:health_management/domain/prescription/entities/prescription_details.dart';
import 'package:health_management/presentation/prescription/bloc/prescription_ai_analysis_bloc.dart';
import 'package:health_management/presentation/prescription/ui/widgets/pop_up_ai.dart';

class MedicineListScreen extends StatelessWidget {
  const MedicineListScreen({
    this.prescriptions,
    Key? key,
  }) : super(key: key);

  final List<PrescriptionDetails>? prescriptions;

  final List<Map<String, dynamic>> medicines = const [
    {
      'name': 'Paracetamol',
      'dosage': '500mg',
      'imageUrl': 'https://via.placeholder.com/150',
      'expirationDate': '2024-12-31',
    },
    {
      'name': 'Ibuprofen',
      'dosage': '400mg',
      'imageUrl': 'https://via.placeholder.com/150',
      'expirationDate': '2025-01-15',
    },
    {
      'name': 'Amoxicillin',
      'dosage': '250mg',
      'imageUrl': 'https://via.placeholder.com/150',
      'expirationDate': '2024-11-10',
    },
    {
      'name': 'Paracetamol',
      'dosage': '500mg',
      'imageUrl': 'https://via.placeholder.com/150',
      'expirationDate': '2024-12-31',
    },
    {
      'name': 'Ibuprofen',
      'dosage': '400mg',
      'imageUrl': 'https://via.placeholder.com/150',
      'expirationDate': '2025-01-15',
    },
    {
      'name': 'Amoxicillin',
      'dosage': '250mg',
      'imageUrl': 'https://via.placeholder.com/150',
      'expirationDate': '2024-11-10',
    },
    {
      'name': 'Paracetamol',
      'dosage': '500mg',
      'imageUrl': 'https://via.placeholder.com/150',
      'expirationDate': '2024-12-31',
    },
    {
      'name': 'Ibuprofen',
      'dosage': '400mg',
      'imageUrl': 'https://via.placeholder.com/150',
      'expirationDate': '2025-01-15',
    },
    {
      'name': 'Amoxicillin',
      'dosage': '250mg',
      'imageUrl': 'https://via.placeholder.com/150',
      'expirationDate': '2024-11-10',
    },
    {
      'name': 'Paracetamol',
      'dosage': '500mg',
      'imageUrl': 'https://via.placeholder.com/150',
      'expirationDate': '2024-12-31',
    },
    {
      'name': 'Ibuprofen',
      'dosage': '400mg',
      'imageUrl': 'https://via.placeholder.com/150',
      'expirationDate': '2025-01-15',
    },
    {
      'name': 'Amoxicillin',
      'dosage': '250mg',
      'imageUrl': 'https://via.placeholder.com/150',
      'expirationDate': '2024-11-10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine List'),
      ),
      body:
          BlocListener<PrescriptionAiAnalysisBloc, PrescriptionAiAnalysisState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          // TODO: implement listener
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
        child: Stack(
          children: [
            ListView.builder(
              itemCount: prescriptions?.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                          child: Image.asset(
                            'assets/images/placeholder.png',
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
                                prescriptions?[index].medication?.name ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Dosage: ${prescriptions?[index].dosage}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Expiration Date: ${prescriptions?[index].medication?.expDate}',
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
              },
            ),
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
                              analyzedMedicines: PrescriptionAiAnalysisRequest(
                                  medicines: (prescriptions ?? [])
                                      .map((e) => e.medication?.name ?? '')
                                      .toList())));
                    },
                    child: Image.asset(
                      'assets/icons/ai_bot.png',
                      height: 40.h,
                      width: 40.w,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
