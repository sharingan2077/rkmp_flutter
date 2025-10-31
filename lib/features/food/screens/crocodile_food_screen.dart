import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:project/features/shared_state/crocodile_provider.dart';
import 'package:project/features/food/widgets/food_item_tile.dart';

class CrocodileFoodScreen extends StatelessWidget {
  const CrocodileFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CrocodileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Питание крокодилов'),
      ),
      body: ListView.builder(
        itemCount: provider.foods.length,
        itemBuilder: (context, index) {
          final food = provider.foods[index];
          return FoodItemTile(food: food);
        },
      ),
    );
  }
}