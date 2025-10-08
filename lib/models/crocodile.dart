class Crocodile {
  final String id;
  final String name;
  final String species;
  final int age;
  final double length;
  final double weight;
  final String healthStatus;
  final DateTime lastFed;
  final String enclosure;

  Crocodile({
    required this.id,
    required this.name,
    required this.species,
    required this.age,
    required this.length,
    required this.weight,
    required this.healthStatus,
    required this.lastFed,
    required this.enclosure,
  });

  Crocodile copyWith({
    String? id,
    String? name,
    String? species,
    int? age,
    double? length,
    double? weight,
    String? healthStatus,
    DateTime? lastFed,
    String? enclosure,
  }) {
    return Crocodile(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      age: age ?? this.age,
      length: length ?? this.length,
      weight: weight ?? this.weight,
      healthStatus: healthStatus ?? this.healthStatus,
      lastFed: lastFed ?? this.lastFed,
      enclosure: enclosure ?? this.enclosure,
    );
  }
}