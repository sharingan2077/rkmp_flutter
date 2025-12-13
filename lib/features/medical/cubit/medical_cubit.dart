// features/medical/cubit/medical_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/medical_record.dart';

class MedicalState {
  final List<MedicalRecord> records;
  final bool isLoading;

  const MedicalState({
    this.records = const [],
    this.isLoading = false,
  });

  MedicalState copyWith({
    List<MedicalRecord>? records,
    bool? isLoading,
  }) {
    return MedicalState(
      records: records ?? this.records,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
// features/medical/cubit/medical_cubit.dart
class MedicalCubit extends Cubit<MedicalState> {
  MedicalCubit() : super(const MedicalState()) {
    _initializeSampleData();
  }

  void _initializeSampleData() {
    final sampleRecords = [
      MedicalRecord(
        id: '1',
        crocodileId: '1',
        crocodileName: 'Гена',
        date: DateTime(2024, 12, 10),
        diagnosis: 'Профилактический осмотр',
        treatment: 'Вакцинация, витаминный комплекс',
        veterinarian: 'Доктор Иванов А.П.',
        notes: 'Крокодил активен, аппетит хороший. Рекомендовано наблюдение.',
        isCompleted: true,
      ),
      MedicalRecord(
        id: '2',
        crocodileId: '2',
        crocodileName: 'Клава',
        date: DateTime(2024, 12, 12),
        diagnosis: 'Травма хвоста',
        treatment: 'Антибиотики (цефтриаксон), перевязка ежедневно',
        veterinarian: 'Доктор Петрова М.И.',
        notes: 'Наблюдать за заживлением. Изолировать от других особей.',
        isCompleted: false,
      ),
    ];

    emit(state.copyWith(records: sampleRecords));
  }

  void addRecord(MedicalRecord record) {
    final updatedRecords = List<MedicalRecord>.from(state.records)..add(record);
    emit(state.copyWith(records: updatedRecords));
  }

  void markAsCompleted(String id) {
    final updatedRecords = state.records.map((record) {
      if (record.id == id) {
        return MedicalRecord(
          id: record.id,
          crocodileId: record.crocodileId,
          crocodileName: record.crocodileName,
          date: record.date,
          diagnosis: record.diagnosis,
          treatment: record.treatment,
          veterinarian: record.veterinarian,
          notes: record.notes,
          isCompleted: true,
        );
      }
      return record;
    }).toList();

    emit(state.copyWith(records: updatedRecords));
  }

  // Получение статистики
// features/medical/cubit/medical_cubit.dart
  Map<String, dynamic> getStats() {
    final total = state.records.length;
    final completed = state.records.where((r) => r.isCompleted).length;
    final inProgress = total - completed;

    // Самые частые диагнозы
    final diagnosisCount = <String, int>{};
    for (final record in state.records) {
      diagnosisCount[record.diagnosis] = (diagnosisCount[record.diagnosis] ?? 0) + 1;
    }

    // Сортируем и берем топ-3
    final sortedDiagnoses = diagnosisCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)); // Используем каскадный оператор

    final topDiagnoses = sortedDiagnoses
        .take(3)
        .map((e) => '${e.key} (${e.value})')
        .toList();

    return {
      'total': total,
      'completed': completed,
      'inProgress': inProgress,
      'topDiagnoses': topDiagnoses,
    };
  }
}