// features/habitats/screens/habitat_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project/features/habitats/models/crocodile_habitat.dart';
import 'package:project/service_locator.dart';
import 'package:project/features/crocodiles/cubit/crocodile_cubit.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:go_router/go_router.dart';

import '../../crocodiles/models/crocodile_status.dart';

class HabitatDetailScreen extends StatelessWidget {
  final CrocodileHabitat habitat;

  const HabitatDetailScreen({super.key, required this.habitat});

  @override
  Widget build(BuildContext context) {
    final crocodileCubit = locator<CrocodileCubit>();

    // Получаем реальных крокодилов по их ID
    final crocodilesInHabitat = crocodileCubit.state.crocodiles
        .where((croc) => habitat.crocodileIds.contains(croc.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(habitat.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Изображение вольера
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: habitat.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                    progressIndicatorBuilder: (context, url, progress) =>
                    const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.nature, color: Colors.green, size: 60),
                      ),
                    ),
                  ),
                  // Градиент для лучшей читаемости
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Название на изображении
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Text(
                      habitat.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Информация о вольере
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Описание
                  Text(
                    habitat.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 20),

                  // Показатели среды
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Параметры среды:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildEnvironmentIndicator(
                                icon: Icons.thermostat,
                                label: 'Температура',
                                value: '${habitat.temperature}°C',
                                color: Colors.orange,
                              ),
                              _buildEnvironmentIndicator(
                                icon: Icons.water_drop,
                                label: 'Влажность',
                                value: '${habitat.humidity}%',
                                color: Colors.blue,
                              ),
                              _buildEnvironmentIndicator(
                                icon: Icons.psychology,
                                label: 'Крокодилов',
                                value: crocodilesInHabitat.length.toString(),
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Список крокодилов
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Крокодилы в этом вольере:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                              ),
                            ),
                            Chip(
                              label: Text(
                                '${crocodilesInHabitat.length} шт.',
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        if (crocodilesInHabitat.isEmpty)
                          const Center(
                            child: Column(
                              children: [
                                Icon(Icons.psychology_outlined,
                                    size: 60, color: Colors.grey),
                                SizedBox(height: 8),
                                Text(
                                  'В этом вольере пока нет крокодилов',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Добавьте крокодила через меню "Крокодилы"',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        else
                          Column(
                            children: crocodilesInHabitat.map((crocodile) {
                              return _buildCrocodileCard(crocodile, context);
                            }).toList(),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnvironmentIndicator({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildCrocodileCard(Crocodile crocodile, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // Можно добавить переход к деталям крокодила
          context.push('/crocodiles/${crocodile.id}');
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Иконка крокодила
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _getStatusColor(crocodile.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.psychology,
                  color: _getStatusColor(crocodile.status),
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),

              // Информация о крокодиле
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crocodile.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      crocodile.species,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            crocodile.status.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(crocodile.status),
                            ),
                          ),
                          backgroundColor:
                          _getStatusColor(crocodile.status).withOpacity(0.1),
                          visualDensity: VisualDensity.compact,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${crocodile.age} лет',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Стрелочка
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Color _getStatusColor(CrocodileStatus status) {
    switch (status) {
      case CrocodileStatus.healthy:
        return Colors.green;
      case CrocodileStatus.needCheckup:
        return Colors.orange;
      case CrocodileStatus.treatment:
        return Colors.red;
    }
  }
}