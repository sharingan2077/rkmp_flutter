// features/habitats/models/crocodile_habitat.dart
class CrocodileHabitat {
  final String id;
  final String name;
  final String description;
  final double temperature;
  final double humidity;
  final String imageUrl;
  final List<String> crocodileIds; // ID крокодилов в этом вольере

  CrocodileHabitat({
    required this.id,
    required this.name,
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.imageUrl,
    this.crocodileIds = const [],
  });
}