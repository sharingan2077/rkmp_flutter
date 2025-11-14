import 'package:flutter/material.dart';
import 'package:project/app_state.dart';
import 'package:project/features/dashboard/widgets/status_chip.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StatusChip(
            title: 'Всего особей',
            value: appState.totalCrocodiles,
            icon: Icons.psychology,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          StatusChip(
            title: 'Здоровы',
            value: appState.healthyCrocodiles,
            icon: Icons.verified,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          StatusChip(
            title: 'Требуют осмотра',
            value: appState.crocodilesNeedCheckup,
            icon: Icons.medical_information,
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          StatusChip(
            title: 'На лечении',
            value: appState.crocodilesOnTreatment,
            icon: Icons.local_hospital,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}