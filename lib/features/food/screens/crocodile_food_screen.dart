import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/food_cubit.dart';
import '../widgets/food_item_tile.dart';

class CrocodileFoodScreen extends StatelessWidget {
  const CrocodileFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Питание крокодилов'),
        ),
        body: BlocBuilder<FoodCubit, FoodState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.foods.length,
              itemBuilder: (context, index) {
                final food = state.foods[index];
                return FoodItemTile(food: food);
              },
            );
          },
        ),
      ),
    );
  }
}