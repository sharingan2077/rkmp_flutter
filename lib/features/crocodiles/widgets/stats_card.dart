import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/widgets/status_chip.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.countHealthyCrocodiles,
    required this.countNeedCheckupCrocodiles,
    required this.countTreatmentCrocodiles
  });

  final int countHealthyCrocodiles;
  final int countNeedCheckupCrocodiles;
  final int countTreatmentCrocodiles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StatusChip(
            title: 'Всего особей',
            value: countHealthyCrocodiles + countTreatmentCrocodiles + countNeedCheckupCrocodiles,
            icon: Icons.psychology,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          StatusChip(
            title: 'Здоровы',
            value: countHealthyCrocodiles,
            icon: Icons.verified,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          StatusChip(
            title: 'Требуют осмотра',
            value: countNeedCheckupCrocodiles,
            icon: Icons.medical_information,
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          StatusChip(
            title: 'На лечении',
            value: countTreatmentCrocodiles,
            icon: Icons.local_hospital,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}