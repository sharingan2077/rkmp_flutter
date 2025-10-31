import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';

class CrocodileTile extends StatelessWidget {
  const CrocodileTile({
    super.key,
    required this.crocodile,
    required this.onDelete,
    required this.onChangeStatus,
  });

  final Crocodile crocodile;
  final VoidCallback onDelete; // Изменили на VoidCallback
  final ValueChanged<CrocodileStatus> onChangeStatus; // Упростили сигнатуру

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
                  onPressed: onDelete, // Теперь просто onDelete без параметров
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
                Text('Состояние: ${crocodile.status.label}'),
                const Spacer(),
                PopupMenuButton<CrocodileStatus>(
                  onSelected: onChangeStatus, // Теперь просто onChangeStatus
                  itemBuilder: (BuildContext context) =>
                      CrocodileStatus.values.map((status) {
                        return PopupMenuItem(
                          value: status,
                          child: Text(status.label),
                        );
                      }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}