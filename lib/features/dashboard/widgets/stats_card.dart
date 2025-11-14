import 'package:flutter/material.dart';
import 'package:project/features/dashboard/widgets/status_chip.dart';
import 'package:project/service_locator.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    if (locator.isRegistered<AppStateService>()) {
      final appStateService = locator.get<AppStateService>();

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StatusChip(
              title: 'Всего особей',
              value: appStateService.totalCrocodiles,
              icon: Icons.psychology,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            StatusChip(
              title: 'Здоровы',
              value: appStateService.healthyCrocodiles,
              icon: Icons.verified,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            StatusChip(
              title: 'Требуют осмотра',
              value: appStateService.crocodilesNeedCheckup,
              icon: Icons.medical_information,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            StatusChip(
              title: 'На лечении',
              value: appStateService.crocodilesOnTreatment,
              icon: Icons.local_hospital,
              color: Colors.red,
            ),
          ],
        ),
      );
    } else {
      print('Ошибка: AppStateService не зарегистрирован в GetIt!');
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Данные недоступны'),
      );
    }
  }
}