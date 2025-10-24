import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/dashboard/widgets/menu_button.dart';
import 'package:project/features/dashboard/widgets/stats_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.statusCounts,
    required this.onList,
    required this.onFood,
    required this.onHabitat,
  });

  final Map<CrocodileStatus, int> statusCounts;
  final void Function() onList;
  final VoidCallback onFood;
  final VoidCallback onHabitat;

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
          const SizedBox(height: 8),
          MenuButton(
            text: "Питание крокодилов",
            icon: Icons.restaurant,
            onPressed: onFood,
          ),
          const SizedBox(height: 8),
          MenuButton(
            text: "Среда обитания",
            icon: Icons.nature,
            onPressed: onHabitat,
          ),
        ],
      ),
    );
  }
}
