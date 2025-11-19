import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/features/food/models/crocodile_food.dart';




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
        imageUrl: 'https://avatars.mds.yandex.net/i?id=df4a18595c421c504a675fa50594c62e_l-5161002-images-thumbs&n=13',
      ),
      CrocodileFood(
        id: '2',
        name: 'Куриное мясо',
        type: 'Мясо',
        quantity: 3.0,
        unit: 'кг',
        imageUrl: 'https://image.made-in-china.com/2f0j00sgpkeIcKhtuq/High-Quality-China-Frozen-Whole-Duck-by-Hand-Slaughter-with-Halal-Certificate.webp',
      ),
    ];

    emit(state.copyWith(foods: sampleFoods));
  }
}