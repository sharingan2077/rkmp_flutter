import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/dashboard/widgets/menu_button.dart';
import 'package:project/features/dashboard/widgets/stats_card.dart';
import 'package:project/features/shared_state/crocodile_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CrocodileProvider>(context);
    final statusCounts = provider.getStatusCounts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Крокодилий заповедник'),
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Горизонтальная навигация - выход
              context.go('/login');
            },
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
              countHealthyCrocodiles: statusCounts[CrocodileStatus.healthy] ?? 0,
              countNeedCheckupCrocodiles: statusCounts[CrocodileStatus.needCheckup] ?? 0,
              countTreatmentCrocodiles: statusCounts[CrocodileStatus.treatment] ?? 0,
            ),
            const SizedBox(height: 16),
            MenuButton(
              text: "Питание крокодилов",
              icon: Icons.restaurant,
              onPressed: () {
                // Вертикальная навигация
                context.push('/food');
              },
            ),
            const SizedBox(height: 8),
            MenuButton(
              text: "Список крокодилов",
              icon: Icons.list,
              onPressed: () {
                // Вертикальная навигация
                context.push('/crocodiles');
              },
            ),
            const SizedBox(height: 8),
            MenuButton(
              text: "Среда обитания",
              icon: Icons.nature,
              onPressed: () {
                // Вертикальная навигация
                context.push('/habitats');
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Горизонтальная навигация - выход
                  context.go('/login');
                },
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