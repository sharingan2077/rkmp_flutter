// features/food/models/crocodile_food.dart
class CrocodileFood {
  final String id;
  final String name;
  final String type;
  final double quantity;
  final String unit;

  CrocodileFood({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.unit,
  });

  CrocodileFood copyWith({
    String? id,
    String? name,
    String? type,
    double? quantity,
    String? unit,
  }) {
    return CrocodileFood(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }
}