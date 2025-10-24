import 'package:flutter/material.dart';
import 'package:project/features/food/model/crocodile_food.dart';
import 'package:project/features/food/widgets/food_item_tile.dart';

class CrocodileFoodScreen extends StatelessWidget {
  final List<CrocodileFood> foods;
  final VoidCallback onBack;

  const CrocodileFoodScreen({
    super.key,
    required this.foods,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        title: const Text('Питание крокодилов'),
      ),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return FoodItemTile(food: food);
        },
      ),
    );
  }
}