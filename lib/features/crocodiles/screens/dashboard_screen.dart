import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/widgets/stats_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Крокодилий заповедник'),
          backgroundColor: Colors.green[700],
        ),
        body: Column(
          children: [
            StatsCard(),
            const SizedBox(height: 16,)
          ],
        )
    );
  }


}
