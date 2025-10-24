import 'package:flutter/material.dart';
import 'package:project/features/habitats/models/crocodile_habitat.dart';
import 'package:project/features/habitats/widgets/habitat_card.dart';

class CrocodileHabitatScreen extends StatelessWidget {
  final List<CrocodileHabitat> habitats;
  final VoidCallback onBack;

  const CrocodileHabitatScreen({
    super.key,
    required this.habitats,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        title: const Text('Среда обитания'),
      ),
      body: ListView.builder(
        itemCount: habitats.length,
        itemBuilder: (context, index) {
          final habitat = habitats[index];
          return HabitatCard(habitat: habitat);
        },
      ),
    );
  }
}