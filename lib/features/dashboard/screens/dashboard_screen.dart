import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/dashboard/widgets/menu_button.dart';
import 'package:project/features/dashboard/widgets/stats_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.statusCounts, required this.onList});

  final Map<CrocodileStatus, int> statusCounts;

  final void Function() onList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Крокодилий заповедник'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          StatsCard(
            countHealthyCrocodiles: statusCounts.putIfAbsent(
              CrocodileStatus.healthy,
              () => 0,
            ),
            countNeedCheckupCrocodiles: statusCounts.putIfAbsent(
              CrocodileStatus.needCheckup,
              () => 0,
            ),
            countTreatmentCrocodiles: statusCounts.putIfAbsent(
              CrocodileStatus.treatment,
              () => 0,
            ),
          ),
          const SizedBox(height: 16),
          MenuButton(
            text: "Учет крокодилов",
            icon: Icons.list,
            onPressed: onList,
          ),
        ],
      ),
    );
  }
}
