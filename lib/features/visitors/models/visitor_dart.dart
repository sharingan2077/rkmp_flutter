// features/visitors/models/visitor.dart
class Visitor {
  final String id;
  final String name;
  final DateTime visitDate;
  final int ticketCount;
  final double totalPrice;
  final String ticketType;

  Visitor({
    required this.id,
    required this.name,
    required this.visitDate,
    required this.ticketCount,
    required this.totalPrice,
    required this.ticketType,
  });

  // Геттеры для удобного форматирования
  String get day => visitDate.day.toString().padLeft(2, '0');
  String get month => visitDate.month.toString().padLeft(2, '0');
  String get year => visitDate.year.toString();
}