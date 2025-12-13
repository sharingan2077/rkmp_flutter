// features/crocodiles/cubit/crocodile_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/crocodile.dart';
import '../models/crocodile_status.dart';

class CrocodileState {
  final List<Crocodile> crocodiles;
  final bool isLoading;
  final String? error;

  const CrocodileState({
    this.crocodiles = const [],
    this.isLoading = false,
    this.error,
  });

  CrocodileState copyWith({
    List<Crocodile>? crocodiles,
    bool? isLoading,
    String? error,
  }) {
    return CrocodileState(
      crocodiles: crocodiles ?? this.crocodiles,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class CrocodileCubit extends Cubit<CrocodileState> {
  CrocodileCubit() : super(const CrocodileState()) {
    _initializeSampleData();
  }

  void addCrocodile(
      String name,
      String species,
      int age,
      double length,
      double weight,
      CrocodileStatus status,
      String enclosure,
      String habitatId,
      ) {
    final newCrocodile = Crocodile(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      species: species,
      age: age,
      length: length,
      weight: weight,
      status: status,
      enclosure: enclosure,
      habitatId: habitatId,
    );

    final updatedCrocodiles = List<Crocodile>.from(state.crocodiles)
      ..add(newCrocodile);

    emit(state.copyWith(crocodiles: updatedCrocodiles));
  }

  void changeStatus(String id, CrocodileStatus status) {
    final updatedCrocodiles = state.crocodiles.map((crocodile) {
      if (crocodile.id == id) {
        return crocodile.copyWith(status: status);
      }
      return crocodile;
    }).toList();

    emit(state.copyWith(crocodiles: updatedCrocodiles));
  }

  void deleteCrocodile(String id) {
    final updatedCrocodiles = state.crocodiles.where((c) => c.id != id).toList();
    emit(state.copyWith(crocodiles: updatedCrocodiles));
  }

  Map<CrocodileStatus, int> getStatusCounts() {
    final result = <CrocodileStatus, int>{};
    for (final crocodile in state.crocodiles) {
      result[crocodile.status] = (result[crocodile.status] ?? 0) + 1;
    }
    return result;
  }

  void _initializeSampleData() {
    final sampleCrocodiles = [
      Crocodile(
        id: '1',
        name: 'Гена',
        species: 'Нильский крокодил',
        age: 15,
        length: 4.2,
        weight: 450.0,
        status: CrocodileStatus.healthy,
        enclosure: 'Тропический вольер A',
        habitatId: '1',
      ),
      Crocodile(
        id: '2',
        name: 'Клава',
        species: 'Гребнистый крокодил',
        age: 12,
        length: 3.8,
        weight: 380.0,
        status: CrocodileStatus.needCheckup,
        enclosure: 'Речной биотоп B',
        habitatId: '2',
      ),
    ];

    emit(state.copyWith(crocodiles: sampleCrocodiles));
  }
}