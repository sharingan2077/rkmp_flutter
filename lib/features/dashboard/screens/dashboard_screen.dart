import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/dashboard/widgets/menu_button.dart';
import 'package:project/features/dashboard/widgets/stats_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.statusCounts,
    required this.onFood,
    required this.onCrocodiles,
    required this.onHabitats,
    required this.onLogout, // Добавляем callback для выхода
  });

  final Map<CrocodileStatus, int> statusCounts;
  final VoidCallback onFood;
  final VoidCallback onCrocodiles;
  final VoidCallback onHabitats;
  final VoidCallback onLogout; // Функция выхода

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Крокодилий заповедник'),
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: false,
        actions: [
          // Кнопка выхода в AppBar
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogout,
            tooltip: 'Выйти',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: 550,
              child: CachedNetworkImage(
                imageUrl: 'https://i.pinimg.com/originals/c1/8c/f1/c18cf15d6886a23d168d4ca9358da24b.png',
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
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
              text: "Питание крокодилов",
              icon: Icons.restaurant,
              onPressed: onFood,
            ),
            const SizedBox(height: 8),
            MenuButton(
              text: "Список крокодилов",
              icon: Icons.list,
              onPressed: onCrocodiles,
            ),
            const SizedBox(height: 8),
            MenuButton(
              text: "Среда обитания",
              icon: Icons.nature,
              onPressed: onHabitats,
            ),
            const SizedBox(height: 16),
            // Дополнительная кнопка выхода в основном контенте
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                onPressed: onLogout,
                icon: const Icon(Icons.logout),
                label: const Text('Выйти'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}