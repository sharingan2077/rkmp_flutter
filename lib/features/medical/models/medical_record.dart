// features/medical/models/medical_record.dart
class MedicalRecord {
  final String id;
  final String crocodileId;
  final String crocodileName;
  final DateTime date;
  final String diagnosis;
  final String treatment;
  final String veterinarian;
  final String? notes; // Новое поле
  final bool isCompleted;

  MedicalRecord({
    required this.id,
    required this.crocodileId,
    required this.crocodileName,
    required this.date,
    required this.diagnosis,
    required this.treatment,
    required this.veterinarian,
    this.notes,
    this.isCompleted = false,
  });

  // Геттеры для удобного форматирования
  String get day => date.day.toString().padLeft(2, '0');
  String get month => date.month.toString().padLeft(2, '0');
  String get year => date.year.toString();
}