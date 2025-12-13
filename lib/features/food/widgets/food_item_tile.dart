// features/food/widgets/food_item_tile.dart
import 'package:flutter/material.dart';
import 'package:project/features/food/models/crocodile_food.dart';

class FoodItemTile extends StatelessWidget {
  final CrocodileFood food;
  final VoidCallback onDelete;

  const FoodItemTile({
    super.key,
    required this.food,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.restaurant,
                color: Colors.green,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        food.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Тип: ${food.type}'),
                  Text('Количество: ${food.quantity} ${food.unit}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}