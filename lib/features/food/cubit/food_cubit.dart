// features/food/cubit/food_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/crocodile_food.dart';


class FoodState {
  final List<CrocodileFood> foods;
  final bool isLoading;

  const FoodState({
    this.foods = const [],
    this.isLoading = false,
  });

  FoodState copyWith({
    List<CrocodileFood>? foods,
    bool? isLoading,
  }) {
    return FoodState(
      foods: foods ?? this.foods,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}


class FoodCubit extends Cubit<FoodState> {
  FoodCubit() : super(const FoodState()) {
    _initializeSampleData();
  }

  void _initializeSampleData() {
    final sampleFoods = [
      CrocodileFood(
        id: '1',
        name: 'Свежая рыба',
        type: 'Рыба',
        quantity: 5.0,
        unit: 'кг',
      ),
      CrocodileFood(
        id: '2',
        name: 'Куриное мясо',
        type: 'Мясо',
        quantity: 3.0,
        unit: 'кг',
      ),
    ];

    emit(state.copyWith(foods: sampleFoods));
  }

  void addFood(
      String name,
      String type,
      double quantity,
      String unit,
      ) {
    final newFood = CrocodileFood(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      type: type,
      quantity: quantity,
      unit: unit,
    );

    final updatedFoods = List<CrocodileFood>.from(state.foods)..add(newFood);
    emit(state.copyWith(foods: updatedFoods));
  }

  void deleteFood(String id) {
    final updatedFoods = state.foods.where((food) => food.id != id).toList();
    emit(state.copyWith(foods: updatedFoods));
  }
}