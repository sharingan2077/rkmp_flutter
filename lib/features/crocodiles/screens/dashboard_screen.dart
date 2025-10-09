import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/widgets/menu_button.dart';
import 'package:project/features/crocodiles/widgets/stats_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.countAllCrocodiles,
    required this.countHealthyCrocodiles,
    required this.countNeedCheckupCrocodiles,
    required this.countTreatmentCrocodiles,
  });

  final String countAllCrocodiles;
  final String countHealthyCrocodiles;
  final String countNeedCheckupCrocodiles;
  final String countTreatmentCrocodiles;

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
            countAllCrocodiles: countAllCrocodiles,
            countHealthyCrocodiles: countHealthyCrocodiles,
            countNeedCheckupCrocodiles: countNeedCheckupCrocodiles,
            countTreatmentCrocodiles: countTreatmentCrocodiles,
          ),
          const SizedBox(height: 16),
          MenuButton(
            text: "Учет крокодилов",
            icon: Icons.list,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
