import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/managers/size_manager.dart';
import 'package:health_management/domain/prescription/entities/prescription_side_effect_risk_entity.dart';

class PopupUI extends StatelessWidget {
  final List<PrescriptionSideEffectRiskEntity> risks;
  final ValueNotifier<int> currentRiskIndexNotifier = ValueNotifier(0);
  PopupUI({required this.risks, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: currentRiskIndexNotifier,
        builder: (context, currentRiskIndex, child) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          height: 630,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1677FF),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            'assets/icons/ai_bot.png',
                            colorBlendMode: BlendMode.srcIn,
                            color: Colors.white,
                            width: 48,
                            height: 48,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Prescrption Analysis By AI',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'AI analysis of potential risks of medicine combinations to ensure safe and effective treatment plans for patients',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Body
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name field
                        const Text('Risk',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            risks[currentRiskIndex].name ?? '',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Conbinations',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                              itemCount: risks[currentRiskIndex]
                                      .combinations
                                      ?.length ??
                                  0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  _buildMedicineItem(
                                    'https://via.placeholder.com/50',
                                    risks[currentRiskIndex]
                                            .combinations?[index] ??
                                        '',
                                  )),
                        ),
                        const SizedBox(height: 16),
                        // Message field
                        const Text('Advice',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            risks[currentRiskIndex].recommendation ?? '',
                            style: const TextStyle(
                              color: Colors.green,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  // Footer
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1677FF),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(12)),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF1677FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                            ),
                            onPressed: () {
                              // Handle back action
                              if (currentRiskIndex > 0) {
                                currentRiskIndexNotifier.value =
                                    currentRiskIndex - 1;
                              }
                            },
                            child: const Text(
                              'Back',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          3.horizontalSpace,
                          Text('${currentRiskIndex + 1}/${risks.length}',
                              style: const TextStyle(color: Colors.white)),
                          3.horizontalSpace,
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF1677FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                            ),
                            onPressed: () {
                              // Handle next action
                              if (currentRiskIndex < risks.length - 1) {
                                currentRiskIndexNotifier.value =
                                    currentRiskIndex + 1;
                              }
                            },
                            child: const Text(
                              'Next',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: -10,
                top: -13,
                child: GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.cancel,
                        color: Colors.white, size: 32)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildMedicineItem(String imageUrl, String name) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.blueAccent),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
