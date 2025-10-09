import 'package:project/features/crocodiles/models/crocodile_status.dart';

class Crocodile {
  final String id;
  final String name;
  final String species;
  final int age;
  final double length;
  final double weight;
  final CrocodileStatus status;
  final String enclosure;


  Crocodile({
    required this.id,
    required this.name,
    required this.species,
    required this.age,
    required this.length,
    required this.weight,
    required this.status,
    required this.enclosure,
  });

  Crocodile copyWith({
    String? id,
    String? name,
    String? species,
    int? age,
    double? length,
    double? weight,
    CrocodileStatus? status,
    String? enclosure,
  }) {
    return Crocodile(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      age: age ?? this.age,
      length: length ?? this.length,
      weight: weight ?? this.weight,
      status: status ?? this.status,
      enclosure: enclosure ?? this.enclosure,
    );
  }
}