import 'package:flutter/material.dart';
import '../models/crocodile.dart';

class CrocodileCard extends StatelessWidget {
  final Crocodile crocodile;
  final VoidCallback onRemove;
  final Function(String) onHealthUpdate;

  const CrocodileCard({
    super.key,
    required this.crocodile,
    required this.onRemove,
    required this.onHealthUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  crocodile.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onRemove,
                ),
              ],
            ),
            Text('Вид: ${crocodile.species}'),
            Text('Возраст: ${crocodile.age} лет'),
            Text('Длина: ${crocodile.length} м'),
            Text('Вес: ${crocodile.weight} кг'),
            Text('Вольер: ${crocodile.enclosure}'),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Состояние: '),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(crocodile.healthStatus),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    crocodile.healthStatus,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (newStatus) => onHealthUpdate(newStatus),
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(value: 'Здоров', child: Text('Здоров')),
                    const PopupMenuItem(value: 'Требует осмотра', child: Text('Требует осмотра')),
                    const PopupMenuItem(value: 'На лечении', child: Text('На лечении')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Здоров':
        return Colors.green;
      case 'Требует осмотра':
        return Colors.orange;
      case 'На лечении':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}