import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/crocodile_habitat.dart';


class HabitatState {
  final List<CrocodileHabitat> habitats;
  final bool isLoading;

  const HabitatState({
    this.habitats = const [],
    this.isLoading = false,
  });

  HabitatState copyWith({
    List<CrocodileHabitat>? habitats,
    bool? isLoading,
  }) {
    return HabitatState(
      habitats: habitats ?? this.habitats,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// features/habitats/cubit/habitat_cubit.dart
class HabitatCubit extends Cubit<HabitatState> {
  HabitatCubit() : super(const HabitatState()) {
    _initializeSampleData();
  }

  void _initializeSampleData() {
    final sampleHabitats = [
      CrocodileHabitat(
        id: '1',
        name: 'Тропический вольер',
        description: 'Просторный вольер с тропической растительностью и бассейном',
        temperature: 28.5,
        humidity: 80.0,
        imageUrl: 'https://images.squarespace-cdn.com/content/v1/568d1cc02399a30df6221280/1528884890037-76N8U4Z58BLB5XJL2NRM/Wildlands_Jungola_JoraVision+3.jpg',
        crocodileIds: ['1'], // Гена живет здесь
      ),
      CrocodileHabitat(
        id: '2',
        name: 'Речной биотоп',
        description: 'Имитация речной среды с проточной водой',
        temperature: 26.0,
        humidity: 75.0,
        imageUrl: 'https://i.pinimg.com/originals/d1/f0/a0/d1f0a01c7fdf1e23f5c926a2ccce4ad6.jpg',
        crocodileIds: ['2'], // Клава живет здесь
      ),
    ];

    emit(state.copyWith(habitats: sampleHabitats));
  }

  // Метод для получения вольера по ID
  CrocodileHabitat? getHabitatById(String id) {
    try {
      return state.habitats.firstWhere((habitat) => habitat.id == id);
    } catch (e) {
      return null;
    }
  }
}